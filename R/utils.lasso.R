lasso <- function(
  X,
  y,
  lambda=1,
  beta0=NULL,
  tol=1e-9,
  max_iter=10000,
  method="approx_ridge",
  print_progress=F
) {
  if(!all(X[,1]==1)) {
    X <- cbind(1,X)
  }
  P <- ncol(X)
  N <- nrow(X)
  # Initialization: ----
  if (is.null(beta0)) {
    beta0 <- qr.solve(X,y)
    beta_latest <- beta0 # naive first guess
  } else {
    beta_latest <- beta0
  }
  converged <- F
  iter_count <- 1
  if (method=="approx_ridge") {
    # Loss function: ----
    loss <- function(beta) {
      return(crossprod(y-X%*%beta) + (lambda/2) * sum(1/abs(beta) * beta^2))
    }
    # Iterative reweighted least-squares (IRLS): ----
    while(!converged & iter_count < max_iter) {
      if (print_progress) {
        print(iter_count)
      }
      wgts <- sapply(beta_latest, function(i) ifelse(abs(i)<1e-20, Inf, i))
      Phi <- diag(1/abs(wgts))
      beta_proposed <- qr.solve(crossprod(X,X)+lambda*Phi,crossprod(X,y))
      chg_loss <- loss(beta_latest) - loss(beta_proposed)
      if (print_progress) {
        print(sprintf("Improvement: %0.9f", chg_loss))
      }
      converged <- abs(chg_loss) < tol
      iter_count <- iter_count + 1
      beta_latest <- beta_proposed
    }
  }
  return(
    list(
      coeff = beta_latest,
      n_iter = iter_count
    )
  )
}
