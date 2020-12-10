sim_from_density = function(dens_est, n=NULL) {
  n = ifelse(is.null(n), dens_est$n, n)
  # 1) Simulate uniformly distributed data:
  U = runif(n)
  # 2) Derive empirical CDF from density estimate
  ecdf = cbind.data.frame(x=dens_est$x,prob=cumsum(dens_est$y/sum(dens_est$y)))
  # Helper function - inverse CDF
  inv_ecdf = function(prob, ecdf) {
    # Find infimum:
    infm=which(ecdf$prob==min(ecdf$prob[ecdf$prob-prob > 0]))
    return(ecdf$x[infm])
  }
  # 3) Apply inverse CDF:
  X = sapply(
    U,
    function(u) {
      inv_ecdf(prob=u, ecdf=ecdf) # there is no closed-form solution for the quantile function of the Binomial
    }
  )
  return(X)
}