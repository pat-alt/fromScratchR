#' Gradient descent
#'
#' @param f Function to be optimized.
#' @param df Gradient of function.
#' @param c Constant used in backtrack condition.
#' @param method Descent method.
#' @param X0 Initial guess.
#' @param step_size0 Initial step size.
#' @param ddf Hessian.
#' @param remember Boolean: should points visited and steps be stored?
#' @param tau Parameter governing the tolerance for convergence.
#' @param backtrack_cond Backtrack method.
#' @param max_iter Maximum number of iterations.
#'
#' @return
#' @export
#'
#' @examples
gradient_desc = function(
  f,df,X0,
  step_size0=1,
  ddf=NULL,
  method="newton",
  c=1e-4,
  remember=TRUE,
  tau=1e-5,
  backtrack_cond = "arminjo",
  max_iter=10000
) {
  # Initialization: ----
  X_latest = matrix(X0)
  if (remember) {
    X = matrix(X0,ncol=length(X0))
    steps = matrix(ncol=length(X0))
  }
  iter = 0
  # Set-up based on method:
  if (method=="steepest") {
    B = function(X) {
      diag(length(X)) # identity
    }
  } else if (method=="newton") {
    B = tryCatch(ddf, error=function(e) {
      stop("Hessian needs to be supplied for Newton's method.")
    }) # Hessian
  }
  # Backtrack condition
  if (backtrack_cond=="arminjo") {
    sufficient_decrease = function(alpha) {
      return(f(X_k + alpha * p_k) <= f(X_k) + c * alpha * t(df_k) %*% p_k) # Arminjo condition
    }
  } else if (is.na(backtrack_cond)) {
    sufficient_decrease = function(alpha) {
      return(f(X_k + alpha * p_k) <= f(X_k)) # Standard condition
    }
  }
  # Run algorithm: ----
  while (any(abs(df(X_latest)-rep(0,length(X_latest)))>tau) & iter < max_iter) { # first-order condition
    X_k = X_latest
    alpha = step_size0 # initialize step size
    df_k = matrix(df(X_latest))
    B_k = B(X_latest)
    p_k = solve(-B_k,df_k) # p_k = - (solve(B_k) %*% df_k)
    # Backtracking:
    while (!sufficient_decrease(alpha)) {
      alpha = alpha/2
    }
    # Update:
    X_latest = X_latest + alpha * p_k
    iter = iter + 1
    if (remember) {
      X = rbind(X, t(X_latest))
      steps = rbind(steps, t(alpha * p_k))
    }
  }
  if (iter>=max_iter) warning("Reached maximum number of iterations without convergence.")
  # Tidy up: ----
  output = list(
    optimal = X_latest,
    visited = tryCatch(X, error=function(e) NULL),
    steps = tryCatch(steps, error=function(e) NULL),
    X0 = X0,
    method = method
  )
  return(output)
}
