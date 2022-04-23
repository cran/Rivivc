\name{NumConv}
\alias{NumConv}
\title{
Numerical convolution
}
\description{
Performs numerical convolution independent of the sampling points but requiring the same timescale of the input and impulse profiles. 
}
\usage{
NumConv(impulse.matrix,input.matrix,conv.timescale = NULL,
    explicit.interpolation = 1000)
}
\arguments{
  \item{impulse.matrix}{
matrix of the PK profile after the drug intravenous (i.v.) administration 
}
  \item{input.matrix}{
cumulative in vivo absorption profile
}
  \item{conv.timescale}{
a timescale of convolution defined either as a whole vector with specific timepoints \code{c(t1,t2,...tN)} or two-element vector containing only lower and upper boundery of the required prediction timescale \code{c(lower,upper)}; in the latter case system creates the time vector based on the parameter \code{explicit.interpolation}; if omitted it computes convolution timescale based on the input matrix
}
  \item{explicit.interpolation}{
sampling accuracy used by the interpolation method to find the same timepoints for input and impulse profiles
}
}
\value{
Output values are:
\item{$par}{ convolved time profile based on the original timescale}
\item{$par_explicit }{provides convolution with the explicit interpolation}
}
\author{
Aleksander Mendyk and Sebastian Polak
}

\seealso{
\code{\link{NumDeconv}},
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

#setting interpolation accuracy
accur_explic<-1000

#run convolution
result<-NumConv(impulse_mtx,input_mtx,explicit.interp=accur_explic)

print("Raw results")
print(result$par)

print("Raw results explicit")
print(result$par_explicit)

dev.new()
plot(resp_mtx)
lines(result$par, type="l", col="blue")

dev.new()
plot(resp_mtx)
lines(result$par_explicit, type="l", col="blue")

}
\keyword{NumConv}
\keyword{ convolution }
