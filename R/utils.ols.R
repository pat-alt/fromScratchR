ols <- function(X, y, weights=NULL) {
  if (!is.null(weights)) {
    Phi <- diag(weights)
    beta <- qr.solve(t(X) %*% Phi %*% X, t(X) %*% Phi %*% y)
  } else {
    beta <- qr.solve(X,y)
  }
  return(beta)
}
