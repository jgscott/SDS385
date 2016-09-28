#include <RcppEigen.h>
#include <algorithm>    // std::max

using namespace Rcpp;
using Eigen::Map;
using Eigen::MatrixXd;
using Eigen::LLT;
using Eigen::Lower;
using Eigen::MatrixXi;
using Eigen::Upper;
using Eigen::VectorXd;
using Eigen::VectorXi;
using Eigen::SparseVector;
typedef Eigen::MappedSparseMatrix<double>  MapMatd;
typedef Map<MatrixXi>  MapMati;
typedef Map<VectorXd>  MapVecd;
typedef Map<VectorXi>  MapVeci;


template <typename T> int sgn(T val) {
  return (T(0) < val) - (val < T(0));
}

inline double invSqrt( const double& x ) {
    double y = x;
    double xhalf = ( double )0.5 * y;
    long long i = *( long long* )( &y );
    i = 0x5fe6ec85e7de30daLL - ( i >> 1 );//LL suffix for (long long) type for GCC
    y = *( double* )( &i );
    y = y * ( ( double )1.5 - xhalf * y * y );
    
    return y;
}


// [[Rcpp::depends(RcppEigen)]]
// [[Rcpp::export]]
SEXP sparsesgd_logit(MapMatd X, VectorXd Y, VectorXd M, double eta, int npass, VectorXd beta0, double lambda=1.0, double discount = 0.01) {
  // X is the design matrix stored in column-major format
  // i.e. with features for case i stores in column i
  // Y is the vector of counts
	// M is the vector of sample sizes
  // Thus Y[i] ~ Binomial( M[i], w[i])  )
  // w[i] = 1/{1+exp(- x[i] dot beta)}
  // where Beta is the regression vector we want to estimate
  // lambda is the l1 regularization parameter

  int numobs = X.cols();
  int numfeatures = X.rows();

  // bookkeeping variables
  SparseVector<double> x(numfeatures);
  int j,k;
  double psi0, yhat, delta, h;

  // Initialize parameters
  double w_hat = (Y.sum() + 1.0) / (M.sum() + 2.0);
  double alpha = log(w_hat/(1.0-w_hat));
  double this_grad = 0.0;
  double g0squared = 0.0;
  double weight;
  double mu, gammatilde;

  // Initialize Gsquared and beta
  VectorXd beta(numfeatures);
  VectorXd Gsquared(numfeatures);
  for(int j=0; j<numfeatures; j++) {
    Gsquared(j) = 1e-3;
    beta(j) = beta0(j);
  }


  // Bookkeeping: how long has it been since the last update of each feature?
  NumericVector last_update(numfeatures, 0.0);

  // negative log likelihood for assessing fit
  double nll_avg = 0.0;
  double epsi;
  NumericVector nll_tracker(npass*numobs, 0.0);

  // Outer loop: number of passes over data set
  k = 0; // global interation counter
  for(int pass=0; pass<npass; pass++) {

    // Loop over each observation (columns of X)
    for(int i=0; i < numobs; i++) {

      // Form linear predictor and E(Y[i]) from features
      x = X.innerVector(i);
      psi0 = alpha + x.dot(beta);
      epsi = exp(psi0);
      yhat = M[i]*epsi/(1.0+epsi);

      // Update nll average
      nll_avg = (1.0-discount)*nll_avg + discount*(M[i]*log(1+epsi) - Y[i]*psi0);
      nll_tracker[k] = nll_avg;

      // Update intercept
      delta = Y[i] - yhat;
      g0squared += delta*delta;
      alpha += (eta/sqrt(g0squared))*delta;

      // if(pass == npass-1) {
      //   loglik += Y[i]*log(yhat) - yhat;
      // }

     // Iterate over the active features for this instance
     for (SparseVector<double>::InnerIterator it(x); it; ++it) {

        // Which feature is this?
        j = it.index();

        // weight for gamma-lasso penalty
        weight = 1.0/(1.0 + fabs(beta(j))); // bigger betas get penalized less

        // Step 1: aggregate all the penalty-only updates since the last time we updated this feature.
        // This is a form of lazy updating in which we approximate all the "penalty-only" updates at once.
        double skip = k - last_update(j);
        h = sqrt(Gsquared(j));
        gammatilde = skip*eta/h;
        beta(j) = sgn(beta(j))*fmax(0.0, fabs(beta(j)) - gammatilde*weight*lambda);

        // Update the last-update vector
        last_update(j) = k;

        // Step 2: Now we compute the update for this observation.

        // gradient of negative log likelihood
        this_grad = -delta*it.value();

        // update adaGrad scaling for this feature
        Gsquared(j) += this_grad*this_grad;

        // scaled stepsize
        h = sqrt(Gsquared(j));
        gammatilde = eta/h;
        // gammatilde = invSqrt(h)*eta;
        mu = beta(j) - gammatilde*this_grad;
        beta(j) = sgn(mu)*fmax(0.0, fabs(mu) - gammatilde*weight*lambda);
      }
      k++; // increment global counter
    }
  }

  // At the very end, apply the accumulated penalty for the variables we haven't touched recently
  for(int j=0; j< numfeatures; j++) {
    double skip = k - last_update(j);
    h = sqrt(Gsquared(j));
    gammatilde = skip*eta/h;
    beta(j) = sgn(beta(j))*fmax(0.0, fabs(beta(j)) - gammatilde*weight*lambda);
  }
 

  return List::create(Named("alpha") = alpha,
                      Named("beta") = beta,
                      Named("nll_tracker") = nll_tracker);
}
