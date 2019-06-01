
#EasyCharts�Ŷӳ�Ʒ���������ñؾ���
#����ʹ��������ѧϰ������ϵ΢�ţ�EasyCharts

library(ggplot2)
library(RColorBrewer)
library(SuppDists) #�ṩrJohnson()����


source("lvplot/calculate.r")
source("lvplot/draw.r")
source("lvplot/lvplot.r")

set.seed(141079)

freq <- 10 ^ (2:5)
findParams <- function(mu, sigma, skew, kurt) {
  value <- .C("JohnsonMomentFitR", as.double(mu), as.double(sigma),
              as.double(skew), as.double(kurt - 3), gamma = double(1),
              delta = double(1), xi = double(1), lambda = double(1),
              type = integer(1), PACKAGE = "SuppDists")
  list(gamma = value$gamma, delta = value$delta,
       xi = value$xi, lambda = value$lambda,
       type = c("SN", "SL", "SU", "SB")[value$type])
}

# ��ֵΪ3����׼��Ϊ1����̬�ֲ�
n <- rnorm(freq[1],3,1)
# Johnson�ֲ���ƫб��2.2�ͷ��13
s <- rJohnson(freq[2], findParams(3, 1, 2, 13.1))
# Johnson�ֲ���ƫб��0�ͷ��20
k <- rJohnson(freq[3], findParams(3, 1, 2.2, 20))
# ������ľ�ֵ��1����2�ֱ�Ϊ1.89��3.79����1 = ��2 =0.31
mm <- rnorm(freq[4], rep(c(2, 4), each = 50) * sqrt(0.9), sqrt(0.1))

mydata <- data.frame(
  group = factor(rep(c("n", "s", "k", "mm"), freq),
                 c("n", "s", "k", "mm")),
  x = c(n, s, k, mm)
)


#pdf("images/letter-value2.pdf", width = 4, height = 4)
par(mar = c(2.1, 2.1, .1, .1))
LVboxplot(mydata$x ~ mydata$group, horizontal = FALSE,col="#F84800",alpha=0.95)
#dev.off()


