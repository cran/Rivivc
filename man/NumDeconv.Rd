\name{NumDeconv}
\alias{NumDeconv}
\title{
Numerical deconvolution method
}
\description{
Numerical deconvolution method based on the convolution and the \code{optim()} BFGS method to find in vivo absorption profile through the convolution approach. The function works iteratively with the cumulative in vivo absorption profile optimization performed by the BFGS method in regard to the convolved PK profile and its proximity to the real known p.o. profile.
}
\usage{
NumDeconv(impulse.matrix,resp.matrix,dose_iv=NULL,dose_po=NULL, 
	    deconv.timescale = NULL, explicit.interpolation = 20, 
	    implicit.interpolation = 10, optim.maxit = 200)
}

\arguments{
  \item{impulse.matrix}{
 matrix of the PK profile after the drug intravenous (i.v.) administration 
}
  \item{resp.matrix}{
PK profile after oral (p.o.) administration of the drug
}

\item{dose_iv}{
drug dose after i.v. administration; not obligatory but if provided must be in the same units like the dose p.o.
}

\item{dose_po}{
drug dose after p.o. administration; not obligatory but if provided must be in the same units like the dose i.v.
}

  \item{deconv.timescale}{
a timescale of deconvolution defined either as a whole vector with specific timepoints \code{c(t1,t2,...tN)} or two-element vector containing only lower and upper boundery of the required prediction timescale \code{c(lower,upper)}; in the latter case system creates the time vector based on the parameter \code{explicit.interpolation}; if omitted it computes deconvolution timescale based on the impulse matrix
}
  \item{explicit.interpolation}{
deconvolution explicit interpolation parameter, namely number of the curve interpolation points used directly by the \code{optim()} method
}
  \item{implicit.interpolation}{
implicit interpolation  - a factor multiplying \code{explicit.interpolation} for better accuracy
}
  \item{optim.maxit}{
maximum number of iterations used by \code{optim()} method
}
}
\details{
This method is an empirical approach to the deconvolution method with minimum mechanistic assumptions. Yet the latter involve kinetics linearity when the doses of i.v. and p.o. are different, thus the i.v. profile is scaled by multiplication with the factor of \code{dose_po/dose_iv}. It is also important to know that large values of explicit and/or implicit accuracy lead to the long execution times. The recommended values are \code{explicit = 20} and \code{implicit = 10}, however this is only a rule of thumb used here. When looking for higher accuracy it is advisable to increase implicit interpolation prior to the explicit.
}
\value{
Three matrices are returned at the output of the function:
\item{$par }{represents original timescale provided at the input}
\item{$par_explicit }{provides deconvolution with the explicit interpolation}
\item{$par_implicit }{provides deconvolution with the implicit interpolation}
}
\author{
Aleksander Mendyk and Sebastian Polak
}

\seealso{
\code{\link{RivivcA}}
}
\examples{

require(Rivivc)
require(graphics)

#i.v. data
data("impulse")
#p.o. PK profile
data("resp")
#in vitro dissolution for correlation purposes
data("input")

#preparing data matrices
input_mtx<-as.matrix(input)
impulse_mtx<-as.matrix(impulse)
resp_mtx<-as.matrix(resp)

#setting accuracy for both interpolation modes
accur_explic<-10
accur_implic<-5


#for deconvolution
result<-NumDeconv(impulse_mtx,resp_mtx,explicit.interp=accur_explic,implicit.interp=accur_implic)


print("Raw results")
print(result$par)

print("Explicit interpolation")
print(result$par_explicit)


print("Implicit interpolation")
print(result$par_implicit)

#let's compare the deconvolved curve with known input
dev.new()
plot(input_mtx)
lines(result$par, type="l", col="blue")


}
\keyword{ NumDeconv }
\keyword{ deconvolution }
