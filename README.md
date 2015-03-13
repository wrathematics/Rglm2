```
 ____       _           ____  
|  _ \ __ _| |_ __ ___ |___ \ 
| |_) / _` | | '_ ` _ \  __) |
|  _ < (_| | | | | | | |/ __/ 
|_| \_\__, |_|_| |_| |_|_____|
      |___/                   


    __     __            _             0.1.0
    \ \   / ___ _ __ ___(_) ___  _ __  
     \ \ / / _ | '__/ __| |/ _ \| '_ \ 
      \ V |  __| |  \__ | | (_) | | | |
       \_/ \___|_|  |___|_|\___/|_| |_|
```


## About 

The Rglm2 package offers an almost identical interface (down to
the very source code) for linear and generalized linear models in
R as those from R's (core) stats package.  However, the functions
in this package use a different backend (the linmod package) for
doing the actual fitting of the linear model.  The goal is to be
able to have identical usage for the R user fitting linear models,
but with a faster, more scalable backend.

The package contains 2 functions: `lm2()` and `glm2()`, and
they are used exactly as you would hope.  The difference is that
`lm2()` uses `linmod::lm_fit()` instead of `stats::lm.fit()`,
and `glm2()` uses `linmod::glm_fit()` instead of `stats::glm.fit()`.

Essentially, these functions aren't in the linmod package itself
to prevent gpl contamination of the linmod package, which is
licensed under a more permissive license.



## License and Copying

The R code in this package contains (slightly) modified versions of
`lm()` and `glm()` (but not `lm.fit()` and `glm.fit()`) from R's 
stats package.  As such, this package is distributed under the
same GPL version 2 license as the original code.  Details of the
modifications are made known in each source file in the R/ tree.

    Copyright (C) 2014 The R Core Team and Drew Schmidt
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    A copy of the GNU General Public License is available at
    http://www.r-project.org/Licenses/



## Requirements and Installation

Installing the package and its dependencies directly from GitHub
is simple via the devtools package:

```r
library(devtools)

install_github("wrathematics/RNACI") # dependency
install_github("wrathematics/linmod") # dependency
install_github("wrathematics/Rglm2")
```



## Usage

You should be able to use this package exactly as you would use
R's own `lm()` and `glm()`, with the only modification that you
change the calls to `lm2()` and `glm2()`.  

So for example, say you had some data that looked like this:

```r
m <- 4000
n <- 250

x <- matrix(rnorm(m*n), m, n)
y <- rnorm(m)
```

In R, you could fit a linear model using `lm()` via:

```r
lm(y~x)
```

With Rglm2, it would be:

```r
library(Rglm2)

lm2(y~x)
```

That's it!  Likewise, the same goes for `glm()`.



## Contact

Drew Schmidt:

* Project home: https://github.com/wrathematics/linmod
* Bug reports: https://github.com/wrathematics/linmod/issues
* Email: wrathematics .AT. gmail.com
* Twitter: @wrathematics

