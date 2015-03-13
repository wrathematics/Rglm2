#  Copyright (C) 1995-2014 The R Core Team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/


# Modifications: 2014, Schmidt
# The following changes were made:
#   * The setting method="qr" was changed to "method="linmod".
#   * The option to use linmod::lm_fit() for model fitting as added.
#   * Model fitting is not longer done by explicit call to stats::lm.fit(),
#     but by the `methodfun()` variable.





#' lm2
#' 
#' Linear model fitter like \code{lm()}, but with the linmod package
#' driving the model fitting.
#' 
#' @param formula
#' 
#' @param data
#' 
#' @param subset
#' 
#' @param weights
#' 
#' @param na.action
#' 
#' @param method
#' 
#' @param model
#' 
#' @param x
#' 
#' @param y
#' 
#' @param qr
#' 
#' @param singular.ok
#' 
#' @param contrasts
#' 
#' @param offset
#' 
#' @param ...
#' Additional arguments.
#' 
#' @return
#' An object of class \code{lm}.
#' 
#' @name lm2
#' @rdname lm2
#' @export
lm2 <- function (formula, data, subset, weights, na.action, method = "linmod", 
    model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
    contrasts = NULL, offset, ..., check.rank=TRUE) 
{
    ret.x <- x
    ret.y <- y
    cl <- match.call()
    mf <- match.call(expand.dots = FALSE)
    m <- match(c("formula", "data", "subset", "weights", "na.action", 
        "offset"), names(mf), 0L)
    mf <- mf[c(1L, m)]
    mf$drop.unused.levels <- TRUE
    mf[[1L]] <- quote(stats::model.frame)
    mf <- eval(mf, parent.frame())
    
    if (method == "model.frame") 
        return(mf)
    else if (method == "qr")
      methodfun <- stats::lm.fit
    else if (method == "linmod")
      methodfun <- linmod::lm_fit
    else
        warning(gettextf("method = '%s' is not supported. Using 'qr'", 
            method), domain = NA)
    
    
    mt <- attr(mf, "terms")
    y <- model.response(mf, "numeric")
    w <- as.vector(model.weights(mf))
    
    if (!is.null(w) && !is.numeric(w)) 
        stop("'weights' must be a numeric vector")
    offset <- as.vector(model.offset(mf))
    
    if (!is.null(offset)) {
        if (length(offset) != NROW(y)) 
            stop(gettextf("number of offsets is %d, should equal %d (number of observations)", 
                length(offset), NROW(y)), domain = NA)
    }
    
    if (is.empty.model(mt)) {
        x <- NULL
        z <- list(coefficients = if (is.matrix(y)) matrix(, 0, 
            3) else numeric(), residuals = y, fitted.values = 0 * 
            y, weights = w, rank = 0L, df.residual = if (!is.null(w)) sum(w != 
            0) else if (is.matrix(y)) nrow(y) else length(y))
        if (!is.null(offset)) {
            z$fitted.values <- offset
            z$residuals <- y - offset
        }
    }
    else {
        x <- model.matrix(mt, mf, contrasts)
        if (is.null(w))
        {
          if (method == "linmod")
            z <- methodfun(x, y, offset = offset, singular.ok = singular.ok, check.rank=check.rank, ...)
          else
            z <- methodfun(x, y, offset = offset, singular.ok = singular.ok, ...)
        }
        ### TODO
        else 
          z <- lm.wfit(x, y, w, offset = offset, singular.ok = singular.ok, ...)
    }
    class(z) <- c(if (is.matrix(y)) "mlm", "lm")
    z$na.action <- attr(mf, "na.action")
    z$offset <- offset
    z$contrasts <- attr(x, "contrasts")
    z$xlevels <- .getXlevels(mt, mf)
    z$call <- cl
    z$terms <- mt
    if (model) 
        z$model <- mf
    if (ret.x) 
        z$x <- x
    if (ret.y) 
        z$y <- y
    if (!qr) 
        z$qr <- NULL
    z
}

