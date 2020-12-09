ridge = function(X, y, lambda, ...) {
  qr.solve(lambda * diag(ncol(X)) + crossprod(X), crossprod(X,y), ...)
}
