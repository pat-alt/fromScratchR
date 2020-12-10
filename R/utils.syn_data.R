# Helper function to create synthetic data sets: ----
library(expm)
syn_data <- function(
  beta = NULL, 
  seed=42, 
  dim=c(1000,10),
  cor=0.8,
  noise_var=10,
  mix_gauss_noise_ratio=25,
  save_to_csv=F,
  path="."
) {
  # Parameters:
  N <- dim[1]
  P <- dim[2]
  if (is.null(beta)) {
    beta <- c(rep(1,ceiling(0.6*P)),rep(0.1,floor(0.4*P)))
  }
  set.seed(seed)
  matrix_grid <- expand.grid(i=1:P,j=1:P)
  Sigma <- matrix(rep(0,P^2),P,P)
  for (x in 1:nrow(matrix_grid)) {
    i <- matrix_grid$i[x]
    j <- matrix_grid$j[x]
    Sigma[i,j] <- 2 * (cor)^(abs(i-j))
  }
  # 1.) Design matrix (as in Zhu et al): ----
  GA <- matrix(rnorm(N*P), nrow = N, ncol = P) %*% expm::sqrtm(t(Sigma))
  # Gaussian mixture:
  gaus_mix <- list(
    gaus_1 = matrix(rnorm(N*P), nrow = N, ncol = P) %*% expm::sqrtm(t(Sigma)),
    gaus_2 = matrix(rnorm(N*P), nrow = N, ncol = P) %*% expm::sqrtm((mix_gauss_noise_ratio * t(Sigma)))
  )
  MG <- matrix(rep(0,N*P),N,P)
  for (i in 1:nrow(MG)) {
    x <- sample(1:2,1)
    MG[i,] <- gaus_mix[[x]][i,]
  }
  # Log-Gaussian:
  LN <- exp(GA)
  # T-distribution:
  T1 <- matrix(rt(N*P,1), nrow = N, ncol = P) %*% expm::sqrtm(t(Sigma))
  # Truncated T:
  TT <- T1
  TT[TT>P] <- P
  TT[TT<(-P)] <- -P
  data_sets <- list(
    GA = list(X = GA),
    MG = list(X = MG),
    LN = list(X = LN),
    TT = list(X = TT),
    T1 = list(X = T1)
  )
  # 2.) Output:
  data_sets <- lapply(
    data_sets,
    function(i) {
      X <- i[["X"]]
      beta <- beta
      eps <- rnorm(n=N,mean=0,sd=sqrt(noise_var))
      y <- X %*% beta + eps
      list(X=X, y=y)
    }
  )
  # 3.) Export:
  if (save_to_csv) {
    lapply(
      1:length(data_sets),
      function(i) {
        name <- sprintf("%s.csv",names(data_sets)[i])
        dt <- data.table::data.table(cbind.data.frame(y = data_sets[[i]]$y, X=data_sets[[i]]$X))
        data.table::fwrite(dt, file.path(path, name))
      }
    )
  }
  return(data_sets)
}