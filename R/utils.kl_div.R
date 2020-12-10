#' KL Divergence
#'
#' @param dens_p Estimate of empirical density.
#' @param dens_q Another estimate of empirical density.
#'
#' @author Patrick Altmeyer
kl_div = function(dens_p,dens_q) {
  # Point estimates:
  p = dens_p$y/sum(dens_p$y)
  q = dens_q$y/sum(dens_q$y)
  kl_pq = sum(
    p * (log(p) - log(q))
  )
  kl_qp = sum(
    q * (log(q) - log(p))
  )
  output = list(
    kl_pq=kl_pq,
    kl_qp=kl_qp
  )
  return(output)
}


