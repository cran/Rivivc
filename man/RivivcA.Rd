\name{RivivcA}
\alias{RivivcA}
\title{
Level A linear correlation for a single formulation
}
\description{
This is the major function to be called where numerical convolution ad/or deconvolution might be used for a linear in vitro in vivo correlation level A. It performes either numerical convolution via /code{NumConv()} or deconvolution via /code{NumDeconv()} and correlates their results with the known.data object via linear regression \code{lm()}. If you just want raw results of convolution/deconvolution then call explicitely \code{\link{NumConv}} or \code{link{NumDeconv}}
}
\usage{
RivivcA(known.data, impulse.data, second.profile.data,dose_iv=NULL,dose_po=NULL, 
	mode = "deconv", explicit.interp = 20, implicit.interp = 10, 
	optimization.maxit = 200)
}
\arguments{
  \item{known.data}{
the data matrix to be correlated with; depending on the state of the \code{mode} variable it represents either in vitro dissolution profile (\code{mode = "deconv"}) or PK profile after oral administration of the drug (\code{mode="conv"})
}
  \item{impulse.data}{
 matrix of the PK profile after the drug i.v. administration 
}
  \item{second.profile.data}{
matrix of the second PK profile; depending on the \code{mode} variable it represents either PK profile after oral administration of the drug (\code{mode = "deconv"}) or a drug cumulative absorption profile (\code{mode="conv"}), sometimes substituted directly by the in vitro dissolution profile
}
  \item{dose_iv}{
drug dose after i.v. administration; not obligatory but if provided must be in the same units like the dose p.o.
}

\item{dose_po}{
drug dose after p.o. administration; not obligatory but if provided must be in the same units like the dose i.v.
}

\item{mode}{
represents the method used here; two states are allowed: \code{mode="conv"} for numerical convolution method or \code{mode="deconv"} for numerical deconvolution (default)
}
  \item{explicit.interp}{
 convolution and deconvolution explicit interpolation parameter, namely number of the curve interpolation points
}
  \item{implicit.interp}{
implicit interpolation  - a factor multiplying \code{explicit.interp} for better accuracy; applies to the deconvolution procedure only
}
  \item{optimization.maxit}{
maximum number of iterations used by \code{optim()} method; applies to the deconvolution procedure only
}
}
\details{
The function represents either convolution or deconvolution data together with linear regression of the above functions outputs and known data supplied as a parameter. Please bear in mind that NumDeconv() procedure is iterative and therefore depending on the parameters might require substantial amount of time to converge. Please refer to the \code{\link{NumDeconv}} description.
}
\value{
\item{$regression }{returns a whole object of the linear regression - a result from the \code{lm()} procedure}
\item{$numeric }{returns results from \code{NumConv()} or \code{NumDeconv()} functions}

}
\author{
Aleksander Mendyk and Sebastian Polak
}

\seealso{
\code{\link{NumConv}}, \code{\link{NumDeconv}}
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

#setting accuracy
accur_explic<-20
accur_implic<-5

#run deconvolution
result<-RivivcA(input_mtx,impulse_mtx,resp_mtx,
    explicit.interp=accur_explic,implicit.interp=accur_implic)

summary(result$regression)

print("Raw results of deconvolution")
print(result$numeric$par)

predicted<-predict(result$regression)
deconvolved_data<-unname(predicted)
orig_data<-input_mtx[,2]

dev.new()
plot(orig_data,result$numeric$par[,2])
lines(orig_data,deconvolved_data, type="l", col="blue")
dev.new()
plot(input_mtx)
lines(result$numeric$par, type="l", col="blue")

}
\keyword{RivivcA}
\keyword{IVIVC Level A}
