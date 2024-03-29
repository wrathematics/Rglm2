% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/glm.r
\name{glm2}
\alias{glm2}
\title{glm2}
\usage{
glm2(formula, family = gaussian, data, weights, subset, na.action,
  start = NULL, etastart, mustart, offset, control = list(...),
  model = TRUE, method = "glm.fit", x = FALSE, y = TRUE,
  contrasts = NULL, ...)
}
\arguments{
\item{formula}{}

\item{family}{}

\item{data}{}

\item{weights}{}

\item{subset}{}

\item{na.action}{}

\item{start}{}

\item{etastart}{}

\item{mustart}{}

\item{offset}{}

\item{control}{}

\item{model}{}

\item{x}{}

\item{y}{}

\item{contrasts}{}

\item{...}{Additional arguments.}

\item{metod}{}
}
\value{
An object of class \code{lm}.
}
\description{
Generalized Linear model fitter like \code{lm()}, but with the linmod
package driving the model fitting.
}

