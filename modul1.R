#nomor 1

##1a
x=3
p=0.20
dgeom(x=3, prob = .2)

##1b
mean(rgeom(n=10000, prob=.2)==3)

##1c
#hasil yang didapatkan hampir atau bahkan persis sama

##1d
library(dplyr)
library(ggplot2)

data.frame(x = 0:10, prob = dgeom(x = 0:10, prob = .2)) %>%
  mutate(Failures = ifelse(x == 3, 3, "other")) %>%
  ggplot(aes(x = factor(x), y = prob, fill = Failures)) +
  geom_col() +
  geom_text(
    aes(label = round(prob,2), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 3,
    vjust = 0
  ) +
  labs(title = "Peluang X = 3 gagal Sebelum Sukses Pertama",
       subtitle = "Geometric(.2)",
       x = "Failures prior to first success (x)",
       y = "Probability")

#histogram thd frekuensi
x <- rgeom(10000, .2) 
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))

##1e
p = 0.2
mean = 1/p
mean

mean(rgeom(n = 10000, prob = .2)) + 1

p = 0.20
var = (1 - p) / p^2
var

var(rgeom(n = 100000, prob = .2))

#nomor 2

##2a
n=20
p=0.2
x=4
dbinom(x=4, size=20, prob=.2) #[1] 0.2181994

##2b
x <- rbinom(10, 20, .2) 
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))

library(dplyr)
library(ggplot2)
#library(scales)

data.frame(heads = 0:10, prob = dbinom(x = 0:10, size = 20, prob = .2)) %>%
  mutate(Heads = ifelse(heads == 4, "4", "other")) %>%
  ggplot(aes(x = factor(heads), y = prob, fill = Heads)) +
  geom_col() +
  geom_text(
    aes(label = round(prob,4), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 2,
    vjust = 0
  ) +
  labs(title = "Probability of X = 4 successes.",
       subtitle = "b(20, .2)",
       x = "Successes (x)",
       y = "probability") 

##2c
#rataan exact
n=20
p=0.2
mean = n * p
mean

#rataan simulated
x <- rbinom(10, 20, .2) 
mean(x) #expected value

#atau
mean(rbinom(n = 10, size = 20, prob = .2))

#varian exact
n=20
p=0.2
var = n * p * (1-p)
var

#varian simulated
x <- rbinom(10, 20, .2) 
var(x) #variance value

#atau
var(rbinom(n = 10, size = 20, prob = .2))

#catatan
#mean(x)=size.p
#var(x)=size.p.(1-p)


#nomor3

##3a
#known rate lambda = 4.5
#use dpois to find values for the probability density function of x, f(x)
#P(x=6)
dpois(x=6, lambda=4.5) #[1] 0.1281201

##3b
#grafik
set.seed(2)

bayi <- data.frame('data' = rpois(365, 4.5))

bayi %>% ggplot() +
  geom_histogram(aes(x = data,
                     y = stat(count / sum(count)),
                     fill = data == 6),
                 binwidth = 1,
                 color = 'black',) +
  scale_x_continuous(breaks = 0:10) + 
  labs(x = 'Banyak bayi lahir setiap periode',
       y = 'Proporsi',
       title = 'kelahiran 6 bayi akan lahir di rumah sakit ini selama setahun (n = 365)') +
  theme_bw()

#display exact value
bayi %>% dplyr::summarize(enam_bayi = sum(bayi$data == 6) / n())

##3c
#hasil 3a dan 3b jauh berbeda

##3d
x <- rpois(365, 4.5) 
mean(x) #expected value

x <- rpois(365, 4.5)  
var(x) #variance value


#nomor 4

##4a
pchisq(2, 10) #[1] 0.003659847

##4b
x <- rchisq(100, 10)
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))

##4c
x <- rchisq(100, 10) 
mean(x) #expected value

x <- rchisq(100, 10)  
var(x) #variance value


#nomor 5

##5a
set.seed(1)
dexp(rexp(1), 3)

##5b
# random data = 10
hist(rexp(10, 3)
     ,main = "Distribution Exponential of 10 random data"
     ,xlab = "variables"
     ,breaks = 15
     ,density = 15)

# random data = 100
hist(rexp(100, 3)
     ,main = "Distribution Exponential of 100 random data"
     ,xlab = "variables"
     ,breaks = 15
     ,density = 15)

# random data = 1000
hist(rexp(1000, 3)
     ,main = "Distribution Exponential of 1000 random data"
     ,xlab = "variables"
     ,breaks = 15
     ,density = 15)

# random data = 10000
hist(rexp(10000, 3)
     ,main = "Distribution Exponential of 10000 random data"
     ,xlab = "variables"
     ,breaks = 15
     ,density = 15)

##5c
#rataan exact
lambda = 3
mean = 1/lambda
mean

#rataan simulated
x <- rexp(100, 3) 
mean(x) #expected value
#atau
mean(rexp(100,3))

#varian exact
n = 100
lambda = 3
var = 1/(lambda^2)
var

#varian simulated
x <- rexp(100, 3)  
var(x) #variance value
#atau
var(rexp(100, 3))

#nomor 6
mean = 50
sd = 8

##6a
ratarata <- mean(rnorm(n=100, mean=50, sd=8))
X1 <- floor(ratarata) - 1
X2 <- ceiling(ratarata)
pnorm(q=X1, mean=50, sd=8, lower.tail=F)
pnorm(q=X2, mean=50, sd=8, lower.tail=T)

Z1 <- (X1 - 50)/8
Z2 <- (X2 - 50)/8

pnorm(q=Z1, mean=50, sd=8, lower.tail=F)
pnorm(q=Z2, mean=50, sd=8, lower.tail=T)

#plot
x <- rnorm(n=100, mean=50, sd=8)
y <- dnorm(x, mean = 50, sd = 8)
plot(x,y)

##6b
hist(randoms, breaks = 50, main = "5025201003_Rahmat_Probstat_F_DNhistogram")

##6c
var(rnorm(n=100, mean=50, sd=8))

