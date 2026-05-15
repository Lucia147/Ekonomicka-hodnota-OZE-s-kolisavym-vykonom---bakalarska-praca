#načítanie dát
#install.packages("readxl")
library(readxl)
Germany_ENTSOE <- read_excel("/Users/luciaresetkova/Desktop/Bakalarka ENTSOE/Germany data 1.25-1.26/Germany all data ENTSOE.xlsx")
Austria_ENTSOE <- read_excel("/Users/luciaresetkova/Desktop/Bakalarka ENTSOE/Austria data 1.25-1.26/Austria all data ENTSOE.xlsx")
Estonia_ENTSOE <- read_excel("/Users/luciaresetkova/Desktop/Bakalarka ENTSOE/Estonia data 1.25-1.26/Estonia all data ENTSOE.xlsx")
Lithuania_ENTSOE <- read_excel("/Users/luciaresetkova/Desktop/Bakalarka ENTSOE/Lithuania data 1.25-1.26/Lithuania all data ENTSOE.xlsx")
attach(Germany_ENTSOE)
attach(Austria_ENTSOE)
attach(Estonia_ENTSOE)
attach(Lithuania_ENTSOE)

#zavedenie premenných
solar <- cbind(
  DE = Germany_ENTSOE$`Solar(MWh)`, 
  AT = Austria_ENTSOE$`Solar(MWh)`, 
  EE = Estonia_ENTSOE$`Solar(MWh)`,
  LT = Lithuania_ENTSOE$`Solar(MWh)`)

for(i in 1:24){
  assign(paste0("solar_", i-1),
         solar[seq(i, nrow(solar), by = 24), ])}

onshorewind <- cbind(
  DE = Germany_ENTSOE$`Wind Onshore(MWh)`, 
  AT = Austria_ENTSOE$`Wind Onshore(MWh)`,
  EE = Estonia_ENTSOE$`Wind Onshore(MWh)`,
  LT = Lithuania_ENTSOE$`Wind Onshore(MWh)`)

for(i in 1:24){
  assign(paste0("onshorewind_", i-1),
         onshorewind[seq(i, nrow(onshorewind), by = 24), ])}

electricity_total <- cbind(
  DE = 439208004.9, 
  AT = 56925894.5, 
  EE = 4813870.38, 
  LT = 9021631.52 
)

lambda_Q_s <- cbind(
  DE = sum(solar[, 1])/electricity_total[1],
  AT = sum(solar[, 2])/electricity_total[2],
  EE = sum(solar[, 3])/electricity_total[3],
  LT = sum(solar[, 4])/electricity_total[4]
)

lambda_Q_nv <- cbind(
  DE = sum(onshorewind[, 1])/electricity_total[1],
  AT = sum(onshorewind[, 2])/electricity_total[2],
  EE = sum(onshorewind[, 3])/electricity_total[3],
  LT = sum(onshorewind[, 4])/electricity_total[4]
)

prices <- cbind(
  DE = Germany_ENTSOE$`Day-ahead(EUR/MWh)`, 
  AT = Austria_ENTSOE$`Day-ahead(EUR/MWh)`,
  EE = Estonia_ENTSOE$`Day-ahead(EUR/MWh)`,
  LT = Lithuania_ENTSOE$`Day-ahead(EUR/MWh)`)

for(i in 1:24){
  assign(paste0("prices_", i-1),
         prices[seq(i, nrow(prices), by = 24), ])}

loads <- cbind(
  DE = Germany_ENTSOE$`Actual Total Load (MWh)`, 
  AT = Austria_ENTSOE$`Actual Total Load(MWh)`,
  EE = Estonia_ENTSOE$`Actual Total Load(MWh)`,
  LT = Lithuania_ENTSOE$`Actual Total Load(MWh)`)

for(i in 1:24){
  assign(paste0("loads_", i-1),
         loads[seq(i, nrow(loads), by = 24), ])}

kappasolar2025 <- c(
  DE = 86951.58, 
  AT = 8254, 
  EE = 1174,
  LT = 1787)

kappasolar2026 <- c(
  DE = 104029.51,
  AT = 9766,
  EE = 1231,
  LT = 3018)  

kappasolar_hourly <-cbind(
  DE = seq(from = kappasolar2025[1], to = kappasolar2026[1], length.out = 8760),
  AT = seq(from = kappasolar2025[2], to = kappasolar2026[2], length.out = 8760),
  EE = seq(from = kappasolar2025[3], to = kappasolar2026[3], length.out = 8760),
  LT = seq(from = kappasolar2025[4], to = kappasolar2026[4], length.out = 8760)
)

kappaonshorewind2025 <- c(
  DE = 63403.17, 
  AT = 4035,
  EE = 682,
  LT = 1683
)

kappaonshorewind2026 <- c(
  DE = 67922.93,
  AT = 4140,
  EE = 694,
  LT = 2507
)

kappaonshorewind_hourly <-cbind(
  DE = seq(from = kappaonshorewind2025[1], to = kappaonshorewind2026[1], length.out = 8760),
  AT = seq(from = kappaonshorewind2025[2], to = kappaonshorewind2026[2], length.out = 8760),
  EE = seq(from = kappaonshorewind2025[3], to = kappaonshorewind2026[3], length.out = 8760),
  LT = seq(from = kappaonshorewind2025[4], to = kappaonshorewind2026[4], length.out = 8760)
)

kappaoffshorewind2025 <- c(
  DE = 9215,
  AT = 0,
  EE = 0,
  LT = 0
)

kappaoffshorewind2026 <- c(
  DE = 9226.42,
  AT = 0,
  EE = 0,
  LT = 0
)

kappatotal2025 <- c(
  DE = 275446.9, 
  AT = 30110, 
  EE = 3473.2, 
  LT = 6305
)

kappatotal2026 <-c(
  DE = 294940.88,
  AT = 33465,
  EE = 3645.2,
  LT = 8840
)

lambda_k_s_2025 <- c(
  DE = kappasolar2025[1]/kappatotal2025[1],
  AT = kappasolar2025[2]/kappatotal2025[2],
  EE = kappasolar2025[3]/kappatotal2026[3],
  LT = kappasolar2025[4]/kappatotal2026[4]
)

lambda_k_s_2026 <-c(
  DE = kappasolar2026[1]/kappatotal2026[1],
  AT = kappasolar2026[2]/kappatotal2026[2],
  EE = kappasolar2026[3]/kappatotal2026[3],
  LT = kappasolar2026[4]/kappatotal2026[4]
)

lambda_k_nv_2025 <- c(
  DE = kappaonshorewind2025[1]/kappatotal2025[1],
  AT = kappaonshorewind2025[2]/kappatotal2025[2],
  EE = kappaonshorewind2025[3]/kappatotal2025[3],
  LT = kappaonshorewind2025[4]/kappatotal2025[4]
)

lambda_k_nv_2026 <- c(
  DE = kappaonshorewind2026[1]/kappatotal2026[1],
  AT = kappaonshorewind2026[2]/kappatotal2026[2],
  EE = kappaonshorewind2026[3]/kappatotal2026[3],
  LT = kappaonshorewind2026[4]/kappatotal2026[4]
)

n_countries <- ncol(solar)

###Kapacitné faktory CF
Eemps <- matrix(NA, nrow = 24, ncol = n_countries)
Eempnv <- Eemps
CF_s <- matrix(NA, nrow = 8760, ncol = n_countries)
CF_nv <- CF_s
colnames(CF_s) <- colnames(solar)
colnames(CF_nv) <- colnames(onshorewind)
maxCF_s <- Eemps
maxCF_nv <- Eemps
EempCFs <- Eemps
EempCFnv <- Eemps

for (i in 1:n_countries) {
  solar_i <- solar[, i]
  onshore_i <- onshorewind[, i]
  kappa_s <- kappasolar_hourly[, i]
  kappa_on <- kappaonshorewind_hourly[, i]
  
  CF_s[, i]  <- solar_i / kappa_s
  CF_nv[, i] <- onshore_i / kappa_on
}

for(i in 1:24){
  assign(paste0("CF_s_", i-1),
         CF_s[seq(i, nrow(CF_s), by = 24), ])}

for(i in 1:24){
  assign(paste0("CF_nv_", i-1),
         CF_nv[seq(i, nrow(CF_nv), by = 24), ])}

for (i in 1:n_countries) {
  for (h in 1:24){
    solar_h <- get(paste0("solar_", h-1))
    onshore_h <- get(paste0("onshorewind_", h-1))
    CF_s_h <- get(paste0("CF_s_", h-1))
    CF_nv_h <- get(paste0("CF_nv_", h-1))
  
    Eemps[h, i] <- mean(solar_h[, i])
    Eempnv[h, i] <- mean(onshore_h[, i])
  
    maxCF_s[h, i] <- max(CF_s_h[,i])
    maxCF_nv[h, i] <- max(CF_nv_h[,i])
    EempCFs[h, i] <- mean(CF_s_h[,i])
    EempCFnv[h, i] <- mean(CF_nv_h[,i])
}}

par(mfrow = c(4,6))
for (i in 1:24){
  vec <- get(paste0("CF_s_", i-1))
  
  hist(vec[, 1],
       main = paste("CF_s_", i-1),  
       xlab = "Value",         
       ylab = "Frequency",     
       col = "orange",         
       border = "white")
}
for (i in 1:24){
  vec <- get(paste0("CF_nv_", i-1))
  
  hist(vec[, 1],
       main = paste("CF_nv_", i-1), 
       xlab = "Value",        
       ylab = "Frequency",      
       col = "skyblue",         
       border = "white")
}
par(mfrow = c(1,1))


###Odhad parametrov mu,sigma metódou maximálnej vierohodnosti
library(MASS)
betapar_s <- array(NA, dim = c(2, n_countries, 24),
                   dimnames = list(c("shape1","shape2"),
                                   NULL,
                                   paste0("h",0:23)))
betapar_nv <- betapar_s
#slnko s vynechanými nočnými hodinami
#Nemecko 0,1,2,3,4, 20,21,22,23
#Rakúsko 0,1,2,3,4, 19,20,21,22,23
#Estónsko 0,1,2, 21,22,23
#Litva 0,1,2 19,20,21,22,23

#Nemecko
for(h in 6:20){
  CF_hour_s <- get(paste0("CF_s_", h-1))
  
  fit_s <- fitdistr(CF_hour_s[, 1] + 1e-5,
                    dbeta,
                    start = list(shape1 = 1, shape2 = 1))
    betapar_s[, 1, h] <- fit_s$estimate
  }

#Rakúsko
for(h in 6:19){
  CF_hour_s <- get(paste0("CF_s_", h-1))
  
  fit_s <- fitdistr(CF_hour_s[, 2] + 1e-5,
                      dbeta,
                      start = list(shape1 = 1, shape2 = 1))
    betapar_s[, 2, h] <- fit_s$estimate
  }

#Estónsko
for(h in 4:21){
  CF_hour_s <- get(paste0("CF_s_", h-1))
  
  fit_s <- fitdistr(CF_hour_s[, 3] + 1e-5,
                      dbeta,
                      start = list(shape1 = 1, shape2 = 1))
    betapar_s[, 3, h] <- fit_s$estimate
  }

#Litva
for(h in 4:19){
  CF_hour_s <- get(paste0("CF_s_", h-1))
  
  fit_s <- fitdistr(CF_hour_s[, 4] + 1e-5,
                      dbeta,
                      start = list(shape1 = 1, shape2 = 1))
    betapar_s[, 4, h] <- fit_s$estimate
  }

#vietor 
for(h in 1:24){
  CF_hour_nv <- get(paste0("CF_nv_", h-1))
  
  for(i in 1:n_countries){
    
    fit_nv <- fitdistr(CF_hour_nv[, i] + 1e-5,
                       dbeta,
                       start = list(shape1 = 1, shape2 = 1))
    betapar_nv[, i, h] <- fit_nv$estimate
  }
}

#QQ ploty
par(mfrow = c(4,6))
for (i in 1:n_countries) {
  for (h in 1:24){
    CF_nv_h <- get(paste0("CF_nv_", h-1))
   
    qqplot(qbeta(ppoints(length(CF_nv_h[, i]+1e-5)), shape1=betapar_nv[1, i, h], shape2=betapar_nv[2, i, h]), CF_nv_h[,i]+1e-10,
           main = paste0("Q-Q plot pre h=",h-1),
           xlab="Teoretické kvantily", ylab="Vzorkové kvantily")
    abline(0,1, col="skyblue") }}

par(mfrow = c(3, 5)) 
for (i in 1:2) {
  for (h in 6:19){
    CF_s_h <- get(paste0("CF_s_", h-1))
  
    qqplot(qbeta(ppoints(length(CF_s_h[, i]+1e-5)), shape1=betapar_s[1, i, h], shape2=betapar_s[2, i, h]), CF_s_h[,i]+1e-10,
             main = paste0("Q-Q plot pre h=",h-1),
             xlab="Teoretické kvantily", ylab="Vzorkové kvantily")
    abline(0,1, col="orange") }}

for (i in 3:4) {
  for (h in 5:19){
    CF_s_h <- get(paste0("CF_s_", h-1))
    
    qqplot(qbeta(ppoints(length(CF_s_h[, i]+1e-5)), shape1=betapar_s[1, i, h], shape2=betapar_s[2, i, h]), CF_s_h[,i]+1e-10,
             main = paste0("Q-Q plot pre h=",h-1),
             xlab="Teoretické kvantily", ylab="Vzorkové kvantily")
    abline(0,1, col="orange") }}
par(mfrow = c(1,1))

# Beta test rozdelenia
#install.packages("goftest")
library(goftest)

results <- list()

for (i in 1:n_countries) {
  for (h in 1:24){
    CF_nv_h <- get(paste0("CF_nv_", h-1))
    results[[paste0("nv_beta_", i,h)]] <- ad.test(CF_nv_h[, i]+1e-10, null="pbeta", shape1 = betapar_nv[1, i, h], shape2 = betapar_nv[2,i,h])
  }}

for (i in 1:n_countries) {
  if(i == 3) next
  for (h in 6:19){
    CF_s_h <- get(paste0("CF_s_", h-1))
    results[[paste0("s_beta_", i,h)]] <- ad.test(CF_s_h[, i]+1e-10, null="pbeta", shape1 = betapar_s[1, i, h], shape2 = betapar_s[2,i,h])
  }}

sapply(results, function(x) x$p.value)*100 #pre vietor Nemecko OK, Rakúsko väčšina OK, Estónsko OK, Litva OK
                                          #pre solar nenulový Nemecko nie, Rakúsko niektoré OK skôr nie, Estónsko, Litva vôbec


par(mfrow = c(3, 5)) 
#solar hustoty
for (i in 1:2) {
  for (h in 6:20){
    CF_s_h <- get(paste0("CF_s_", h-1))
    hist(CF_s_h[, i], nclass = "Freedman-Diaconis", prob = TRUE,
       main = NULL, xlab = NULL,
       ylab = NULL,
       col = "grey")
  
    lines(density(CF_s_h[, i]), col = "black")
  
    curve(dbeta(x,
              shape1 = betapar_s[1, i, h],
              shape2 = betapar_s[2, i, h]),
        from = 0, to = 1, add = TRUE, col = "orange", lwd = 2)
    
    legend("topright", legend = paste0("h=", h-1), adj = 0.4)
    if(h == 6 && (i == 1 || i == 2)){
      legend("topright",
           legend = c("Histogram", "Kernel", "Beta"),
           col = c("grey", "black", "orange"),
           lwd = c(NA, 2, 2),
           lty = c(NA, 1, 1),
           pch = c(15, NA, NA),
           cex = 0.9)}
}}

for (i in 3:4) {
  for (h in 5:19){
    CF_s_h <- get(paste0("CF_s_", h-1))
    hist(CF_s_h[, i], nclass = "Freedman-Diaconis", prob = TRUE,
         main = NULL, xlab = NULL,
         ylab = NULL,
         col = "grey")
    
    lines(density(CF_s_h[, i]), col = "black")
    
    curve(dbeta(x,
                shape1 = betapar_s[1, i, h],
                shape2 = betapar_s[2, i, h]),
          from = 0, to = 1, add = TRUE, col = "orange", lwd = 2)
    
    legend("topright", legend = paste0("h=", h-1), adj = 0.4)
    if(h == 5 && (i == 4 || i == 5)){
      legend("topright",
             legend = c("Histogram", "Kernel", "Beta"),
             col = c("grey", "black", "orange"),
             lwd = c(NA, 2, 2),
             lty = c(NA, 1, 1),
             pch = c(15, NA, NA),
             cex = 0.9)}
  }}

#onshorewind hustoty
par(mfrow = c(6,4), mar = c(3, 3, 2, 1))
for (i in 1:n_countries) {
  for (h in 1:24){
    CF_nv_h <-get(paste0("CF_nv_", h-1))
    hist(CF_nv_h[, i], nclass = "Freedman-Diaconis", prob = TRUE,
       main = NULL, xlab = paste0("CF_nv v hodine h=",h-1),
 
       col = "grey")
  
    lines(density(CF_nv_h[, i]), col = "black")
  
    curve(dbeta(x,
              shape1 = betapar_nv[1, i, h],
              shape2 = betapar_nv[2, i, h]),
        from = 0, to = 1, add = TRUE, col = "blue", lwd = 2)
  
    legend("topright", legend = paste0("h=", h-1), adj = 0.4)
    if(h == 1){
      legend("topright",
           legend = c("Histogram", "Kernel", "Beta"),
           col = c("grey", "black", "blue"),
           lwd = c(NA, 2, 2),
           lty = c(NA, 1, 1),
           pch = c(15, NA, NA),
           cex = 0.8)}
}}
par(mfrow = c(1,1))

#vlastnosti beta rozdelenia
EDteor_s <- array(NA, dim = c(2, n_countries, 24), 
                  dimnames = list(c("strednáhodnota", "disperzia"),
                                  NULL,
                                  paste0("h",0:23)))
EDemp_s <- EDteor_s
EDteor_nv <- EDteor_s
EDemp_nv <- EDteor_s
empbetapar_s <- EDteor_s
empbetapar_nv <- EDteor_s

for (i in 1:n_countries) {
  for (h in 1:24){
    m_s <- betapar_s[1, i, h]
    n_s <- betapar_s[2, i, h]
    m_nv <- betapar_nv[1, i, h]
    n_nv <- betapar_nv[2, i, h]

    EDteor_s[1, i, h] <- m_s/(m_s+n_s)
    EDteor_s[2, i, h] <- m_s*n_s/((m_s+n_s+1)*(m_s+n_s)^2)
    EDteor_nv[1, i, h] <- m_nv/(m_nv+n_nv)
    EDteor_nv[2, i, h] <- m_nv*n_nv/((m_nv+n_nv+1)*(m_nv+n_nv)^2)

    CF_hour_s <- get(paste0("CF_s_", h-1))
    CF_hour_nv <- get(paste0("CF_nv_", h-1))
    EDemp_s[1, i, h] <- mean(CF_hour_s[, i])
    EDemp_s[2, i, h] <- var(CF_hour_s[, i])
    EDemp_nv[1, i, h] <- mean(CF_hour_nv[, i])
    EDemp_nv[2, i, h] <- var(CF_hour_nv[, i])
  
    empbetapar_s[1, i, h] <- ((1-EDemp_s[1,i,h])*(EDemp_s[1,i,h]^2)-EDemp_s[2,i,h]*EDemp_s[1,i,h])/EDemp_s[2,i,h]
    empbetapar_s[2, i, h] <- ((1-EDemp_s[1,i,h])*empbetapar_s[1, i, h])/EDemp_s[1,i,h]
    empbetapar_nv[1, i, h] <- ((1-EDemp_nv[1,i,h])*(EDemp_nv[1,i,h]^2)-EDemp_nv[2,i,h]*EDemp_nv[1,i,h])/EDemp_nv[2,i,h]
    empbetapar_nv[2, i, h] <- ((1-EDemp_nv[1,i,h])*empbetapar_nv[1, i, h])/EDemp_nv[1,i,h]
  }}

EDteor_s[, 1:2, 1:5] <- 0 
EDteor_s[, 1, 21:24] <- 0
EDteor_s[, 2, 20:24] <- 0
EDteor_s[, 3:4, 1:3] <- 0
EDteor_s[, 3, 22:24] <- 0
EDteor_s[, 4, 20:24] <- 0

###Kovariancie 
covCFCF <- matrix(NA, nrow = 24, ncol = n_countries)
corCFCF <- covCFCF
covDCFs <- covCFCF
covDCFnv <-covCFCF
covQQ <- covCFCF
corQQ <- covCFCF
covDQ_s <- covCFCF
covDQ_nv <- covCFCF
for (i in 1:n_countries) {
  for (h in 1:24){
    solar_hh <- get(paste0("solar_", h-1))
    onshorewind_hh <- get(paste0("onshorewind_", h-1))
    demand_h <- get(paste0("loads_", h-1))
    CF_s_h <- get(paste0("CF_s_", h-1))
    CF_nv_h <- get(paste0("CF_nv_", h-1))
    
    covCFCF[h, i] <- cov(CF_s_h[, i], CF_nv_h[, i]) #*kappasolar2026[i]*kappaonshorewind2026[i]
    covDCFs[h,i] <- cov(demand_h[, i], CF_s_h[,i])
    covDCFnv[h,i] <- cov(demand_h[, i], CF_nv_h[, i])
    if(!is.na(EDteor_s[2, i, h]) && EDteor_s[2, i, h] != 0){
      corCFCF[h, i] <- cor(CF_s_h[, i], CF_nv_h[, i])}
    
    covQQ[h, i] <- cov(solar_hh[, i], onshorewind_hh[, i])
    corQQ[h, i] <- cor(solar_hh[, i], onshorewind_hh[, i])
    covDQ_s[h, i] <- cov(demand_h[, i], solar_hh[, i])
    covDQ_nv[h, i] <- cov(demand_h[, i], onshorewind_hh[, i])
     }}


###Reziduálny dopyt a model ceny
renewables <- cbind(
  DE = Germany_ENTSOE$`Solar(MWh)` + Germany_ENTSOE$`Wind Onshore(MWh)` , 
  AT = Austria_ENTSOE$`Solar(MWh)` + Austria_ENTSOE$`Wind Onshore(MWh)`, 
  EE = Estonia_ENTSOE$`Solar(MWh)` + Estonia_ENTSOE$`Wind Onshore(MWh)`,
  LT = Lithuania_ENTSOE$`Solar(MWh)` + Lithuania_ENTSOE$`Wind Onshore(MWh)`)
  
for(i in 1:24){
  assign(paste0("renewables_", i-1),
         renewables[seq(i, nrow(renewables), by = 24), ])}

residual_demand <- cbind(
  DE = loads[, 1] - renewables[, 1],
  AT = loads[, 2] - renewables[, 2],
  EE = loads[, 3] - renewables[, 3],
  LT = loads[, 4] - renewables[, 4])

for(i in 1:24){
  assign(paste0("residual_demand_", i-1),
         residual_demand[seq(i, nrow(residual_demand), by = 24), ])}

abpriamky <- array(NA, dim = c(2, n_countries, 24), 
                  dimnames = list(c("a", "b"),
                                  NULL,
                                  paste0("h",0:23)))

cenaMODEL <- matrix(vector("list", 24 * n_countries), 
                    nrow = 24, 
                    ncol = n_countries)

abcquadratic <- array(NA, dim = c(3, n_countries, 24), 
                      dimnames = list(c("a", "b", "c"),
                                      NULL,
                                      paste0("h",0:23)))

cenaMODELquadratic <- cenaMODEL

par(mfrow = c(6,4), mar = c(2, 2, 2, 1), oma = c(2.5, 2.5, 1, 1))
for (i in 1:n_countries) {
  for (h in 1:24){
    residual_demand_h <- get(paste0("residual_demand_", h-1))
    prices_h <- get(paste0("prices_", h-1))
    
    plot(residual_demand_h[, i], prices_h[, i], main = paste0("h=", h-1))
  
    cenaMODELquadratic[[h, i]] <- lm(formula = prices_h[, i]~1 + residual_demand_h[, i] + I(residual_demand_h[,i]^2), x=TRUE )
    summary(cenaMODELquadratic[[h, i]])
    osX <- seq(min(residual_demand_h[, i]) , max(residual_demand_h[, i]) , length.out=100)
    lines(osX , cenaMODELquadratic[[h, i]]$coeff[1] + cenaMODELquadratic[[h, i]]$coeff[2]*osX + cenaMODELquadratic[[h, i]]$coeff[3]*osX^2, col="green", lwd = 1.5)
    abcquadratic[, i, h] <- cenaMODELquadratic[[h, i]]$coeff
  
    cenaMODEL[[h, i]] <- lm(formula = prices_h[, i]~1+residual_demand_h[, i])
    summary(cenaMODEL[[h, i]])
    abline(cenaMODEL[[h, i]]$coeff, col="red", lwd=1.5)
    abpriamky[, i, h] <-cenaMODEL[[h, i]]$coeff
    
  mtext("Reziduálny dopyt", side = 1, outer = TRUE, line = 1, cex = 1.2)
  mtext("Cena", side = 2, outer = TRUE, line = 1, cex = 1.2)
  }}

par(mfrow = c(1,1))

#Koeficient determinácie
R2 <- matrix(NA, nrow = 24, ncol = n_countries)
R2_quadratic <- R2

for (i in 1:n_countries){
  for (h in 1:24){
    R2[h, i] <- summary(cenaMODEL[[h, i]])$r.squared
    R2_quadratic[h, i] <- summary(cenaMODELquadratic[[h, i]])$r.squared
  }
}
mean(R2_quadratic[, 4])

#Testy normality chýb regresie
resultsregresia <- list()

for (i in 1:n_countries) {
  for (h in 1:24){
    resultsregresia[[paste0(i,h)]] <- ks.test( resid(cenaMODEL[[h,i]]), "pnorm" , mean=mean(resid(cenaMODEL[[h,i]])) ,sd=sqrt(var(resid(cenaMODEL[[h,i]]))) ) 
  }}

sapply(resultsregresia, function(x) x$p.value)*100

###Cov statické výsledky
trzbysolar <- cbind(
  DE = prices[, 1] * solar[, 1],
  AT = prices[, 2] * solar[, 2],
  EE = prices[, 3] * solar[, 3],
  LT = prices[, 4] * solar[, 4]
)

for(i in 1:24){
  assign(paste0("trzbysolar_", i-1),
         trzbysolar[seq(i, nrow(trzbysolar), by = 24), ])}

trzbyonshorewind <- cbind(
  DE = prices[, 1] * onshorewind[, 1],
  AT = prices[, 2] * onshorewind[, 2],
  EE = prices[, 3] * onshorewind[, 3],
  LT = prices[, 4] * onshorewind[, 4]
)

for(i in 1:24){
  assign(paste0("trzbyonshorewind_", i-1),
         trzbyonshorewind[seq(i, nrow(trzbyonshorewind), by = 24), ])}

EPQmean <- array(NA, dim = c(2, n_countries, 24), 
                 dimnames = list(c("slnko", "vietor"),
                                 NULL,
                                 paste0("h",0:23)))

for (i in 1:n_countries) {
  for (h in 1:24){
    trzbysolar_h <- get(paste0("trzbysolar_", h-1))
    trzbyonshorewind_h <- get(paste0("trzbyonshorewind_", h-1))
    
    EPQmean[1,i,h] <- mean(trzbysolar_h[,i])
    EPQmean[2,i,h] <- mean(trzbyonshorewind_h[,i])
  }}

covPQ_s <- array(NA, dim = c(9, n_countries, 24), 
                 dimnames = list(c("cov_teor_model1", "cov_emp_model1", "cov_teor_model2", "cov_emp_model2", "cov_teor_model3", "cov_emp_model3", "cov_teor_model4", "cov_emp_model4", "cov_vyberovy"),
                                 NULL,
                                 paste0("h",0:23)))

covPQ_nv <- covPQ_s

for (i in 1:n_countries) {
  for (h in 1:24){
    trzbysolar_h <- get(paste0("trzbysolar_", h-1))
    trzbyonshorewind_h <- get(paste0("trzbyonshorewind_", h-1))
    kappasolar <- (kappasolar2025 + kappasolar2026)/2
    kappaonshorewind <- (kappaonshorewind2025 + kappaonshorewind2026)/2
    prices_h <- get(paste0("prices_", h-1))
    solar_h <- get(paste0("solar_", h-1))
    onshorewind_h <- get(paste0("onshorewind_", h-1))
  
    covPQ_s[1, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDteor_s[2,i,h])
    covPQ_s[2, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDemp_s[2,i,h])
    covPQ_s[3, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDteor_s[2,i,h])+(abpriamky[2, i, h]*covDQ_s[h, i])
    covPQ_s[4, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDemp_s[2,i,h])+(abpriamky[2, i, h]*covDQ_s[h, i])
    covPQ_s[5, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDteor_s[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i]) 
    covPQ_s[6, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDemp_s[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i])
    covPQ_s[7, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDteor_s[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i]) +(abpriamky[2, i, h]*covDQ_s[h, i])
    covPQ_s[8, i, h] <- (-abpriamky[2, i, h]*(kappasolar[i]^2)*EDemp_s[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i]) +(abpriamky[2, i, h]*covDQ_s[h, i])
    covPQ_s[9, i, h] <- mean(trzbysolar_h[, i]) - mean(prices_h[, i])*mean(solar_h[, i])
    
    covPQ_nv[1, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDteor_nv[2,i,h])
    covPQ_nv[2, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDemp_nv[2,i,h])
    covPQ_nv[3, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDteor_nv[2,i,h])+(abpriamky[2, i, h]*covDQ_nv[h, i])
    covPQ_nv[4, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDemp_nv[2,i,h])+(abpriamky[2, i, h]*covDQ_nv[h, i])
    covPQ_nv[5, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDteor_nv[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i])
    covPQ_nv[6, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDemp_nv[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i])
    covPQ_nv[7, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDteor_nv[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i]) +(abpriamky[2, i, h]*covDQ_nv[h, i])
    covPQ_nv[8, i, h] <- (-abpriamky[2, i, h]*(mean(kappaonshorewind[i])^2)*EDemp_nv[2,i,h])-(abpriamky[2, i, h]*covQQ[h, i]) +(abpriamky[2, i, h]*covDQ_nv[h, i])
    covPQ_nv[9, i, h] <- mean(trzbyonshorewind_h[, i]) - mean(prices_h[, i])*mean(onshorewind_h[, i])
  }}


###Zmena absolutnej cov s trhovým podielom
cov_s <-  array(NA, dim = c(20, n_countries, 24),
                                NULL)
cov_nv <- cov_s

#model 4, cez lambdy
for (k in 1:20) {
  for (h in 1:24){
    lambda <- 0.1+k*0.03
    kappa_s <- (kappasolar2025+kappasolar2026)/2
    kappa_t <- (kappatotal2025+kappatotal2026)/2
    cov_s[k, 1, h] <- (-abpriamky[2, 1, h] * (lambda/(1-lambda))^2 * (kappa_t[1] - kappa_s[1])^2 * EDteor_s[2,1,h]) -(abpriamky[2, 1, h]*covQQ[h, 1]) +(abpriamky[2, 1, h]*covDQ_s[h, 1]) 
    cov_s[k, 2, h] <- (-abpriamky[2, 2, h] * (lambda/(1-lambda))^2 * (kappa_t[2] - kappa_s[2])^2* EDteor_s[2,2,h]) -(abpriamky[2, 2, h]*covQQ[h, 2]) +(abpriamky[2, 2, h]*covDQ_s[h, 2])
    cov_s[k, 3, h] <- (-abpriamky[2, 3, h] * (lambda/(1-lambda))^2 * (kappa_t[3] - kappa_s[3])^2* EDteor_s[2,3,h]) -(abpriamky[2, 3, h]*covQQ[h, 3]) +(abpriamky[2, 3, h]*covDQ_s[h, 3])
    cov_s[k, 4, h] <- (-abpriamky[2, 4, h] * (lambda/(1-lambda))^2 * (kappa_t[4] - kappa_s[4])^2* EDteor_s[2,4,h]) -(abpriamky[2, 4, h]*covQQ[h, 4])+(abpriamky[2, 4, h]*covDQ_s[h, 4])
    }}

for (k in 1:20) {
  for (h in 1:24){
    lambda <- 0.1 +k*0.03
    kappa_nv <- (kappaonshorewind2025+kappaonshorewind2026)/2
    kappa_t <- (kappatotal2025+kappatotal2026)/2
  cov_nv[k, 1, h] <- (-abpriamky[2, 1, h] * (lambda/(1-lambda))^2 * (kappa_t[1] - kappa_nv[1])^2 * EDteor_nv[2,1,h]) -(abpriamky[2, 1, h]*covQQ[h, 1] + (abpriamky[2, 4, h]*covDQ_nv[h, 4])) 
  cov_nv[k, 2, h] <- (-abpriamky[2, 2, h] * (lambda/(1-lambda))^2 * (kappa_t[2] - kappa_nv[2])^2 *EDteor_nv[2,2,h]) -(abpriamky[2, 2, h]*covQQ[h, 2]) + (abpriamky[2, 4, h]*covDQ_nv[h, 4])
  cov_nv[k, 3, h] <- (-abpriamky[2, 3, h] * (lambda/(1-lambda))^2 * (kappa_t[3] - kappa_nv[3])^2 *EDteor_nv[2,3,h]) -(abpriamky[2, 3, h]*covQQ[h, 3]) + (abpriamky[2, 4, h]*covDQ_nv[h, 4])
  cov_nv[k, 4, h] <- (-abpriamky[2, 4, h] * (lambda/(1-lambda))^2 * (kappa_t[4] - kappa_nv[4])^2 * EDteor_nv[2,4,h]) -(abpriamky[2, 4, h]*covQQ[h, 4]) + (abpriamky[2, 4, h]*covDQ_nv[h, 4])
  }}


par(mfrow = c(3, 5), mar = c(2, 2, 2, 1), oma = c(2.5, 3, 1, 1))
K <- seq(from = 10, by = 3, length.out = 20)
country_names <- c("Nemecko", "Rakúsko", "Estónsko", "Litva")

#vykreslenie všetkých 4 krajín - solar
for (h in 6:20) {
  
  colors <- rainbow(n_countries)
  # najprv vytvoríme prázdny plot s vhodným rozsahom
  plot(K, cov_s[, 1, h], type="n",
       ylim = c(-1e+06, 2e+02),
       xlab = "Kapacitný podiel (%)", ylab = "cov(P,Q)",
       main = paste("h=", h-1),
       yaxt = "n")
  #formatovanie osi y
  y_ticks <- pretty(c(-1e+06, 2e+02))
  
  axis(2, at = y_ticks,
       labels = format(y_ticks, big.mark = " ", scientific = FALSE))
  
  # pridáme jednotlivé krajiny
  for (i in 1:n_countries) {
    idx_s <- which.min(abs(-cov_s[, i, h] - EPQmean[1, i, h]))
    lines(K, cov_s[, i, h], col=colors[i], lwd=1.5)
    points(K[idx_s], cov_s[,i,h][idx_s], col=colors[i], pch=19, cex=1.2)
  }
  
  if (h==6){
    legend("bottomleft", 
         legend = country_names,   
         col = colors, 
         lty = 1,
         lwd = 1.2,
         cex = 1.2)
}}
mtext(expression("Kapacitný podiel" ~ lambda[s] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(Cov(P[h], Q[h*","*s])~(EUR)), side = 2, outer = TRUE, line = 1, cex = 1.2)

#vykreslenie všetkých 4 krajín - vietor
par(mfrow=c(4,6))
for (h in 1:24) {
  colors <- rainbow(n_countries)
  # najprv vytvoríme prázdny plot s vhodným rozsahom
  plot(K, cov_nv[, 1, h], type="n",
       ylim = c(-3e+06, 2e+04),
       xlab = "Kapacitný podiel (%)", ylab = "cov(P,Q)",
       main = paste("h=", h-1),
       yaxt = "n")
  
  #formatovanie osi y
  y_ticks <- pretty(c(-3e+06, 2e+04))
  
  axis(2, at = y_ticks,
       labels = format(y_ticks, big.mark = " ", scientific = FALSE))
  
  
  # pridáme jednotlivé krajiny
  for (i in 1:n_countries) {
    idx_nv <- which.min(abs(-cov_nv[, i, h] - EPQmean[2, i, h]))
    lines(K, cov_nv[, i, h], col=colors[i], lwd=1.5)
    points(K[idx_nv], cov_nv[,i,h][idx_nv], col=colors[i], pch=19, cex=1.2)} 
  if(h == 1 ){
    legend("bottomleft", 
         legend = country_names,   
         col = colors, 
         lty = 1,
         lwd = 1.2,
         cex = 0.8)}}
mtext(expression("Kapacitný podiel" ~ lambda[nv] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(Cov(P[h], Q[h*","*nv]) ~ (EUR)), side = 2, outer = TRUE, line = 1, cex = 1.2)


###Zmena cov relativna
cov_s_relat_1 <- array(NA, dim = c(15, n_countries, 24), NULL)
cov_s_relat_2 <- cov_s_relat_1
cov_s_relat_3 <- cov_s_relat_1
cov_s_relat_4 <- cov_s_relat_1
cov_s_relat_4_emp <- cov_s_relat_1
cov_s_relat_4_CF <- cov_s_relat_1
cov_nv_relat_1 <- cov_s_relat_1
cov_nv_relat_2 <- cov_s_relat_1
cov_nv_relat_3 <- cov_s_relat_1
cov_nv_relat_4 <- cov_s_relat_1

R_cov_4_den_s <-matrix(NA, nrow= 15, ncol = n_countries)
R_cov_4_den_nv <- R_cov_4_den_s

revenues_prax_4 <- array(NA, dim = c(15, n_countries, 24), 
                   NULL)
revenues_teor_4_s <- revenues_prax_4
revenues_teor_4_nv <- revenues_prax_4
cenamnozstvo_h_4 <- matrix(NA, nrow = 365, ncol = 2)
#cov_skuska <- cov_s_relat_4
#abschyba_skuska <- cov_s_relat_4

# R_{cov,4}, teor, Q
for (i in 1:n_countries) {
  print(i)
  for (k in 1:15) {
    citatel_den_s <-0
    menovatel_den_s <-0
    citatel_den_nv <- 0
    menovatel_den_nv <- 0
    
    for (h in 1:24){
      lambda <- (0.1+k*0.03)
      kappa_bezs <- ((kappatotal2025[i]-kappasolar2025[i])+(kappatotal2026[i]-kappasolar2026[i]))/2
      kappa_beznv <- ((kappatotal2025[i]-kappaonshorewind2025[i])+(kappatotal2026[i]-kappaonshorewind2026[i]))/2
      loads_h <- get(paste0("loads_", h-1))
      solar_h <- get(paste0("solar_",h-1))
      onshorewind_h <- get(paste0("onshorewind_", h-1))
      CF_s_h <- get(paste0("CF_s_", h-1))
      CF_nv_h <- get(paste0("CF_nv_", h-1))
      
      #R_cov4 pre solar a vietor
      clen3_s <- ((lambda*kappa_bezs)/(1-lambda))^2 * EDteor_s[2, i, h]
      clen3_nv <- ((lambda*kappa_beznv)/(1-lambda))^2 * EDteor_nv[2, i, h]
      vynaty_clen <- abpriamky[2, i, h] 
      
      abschyba_s_i <- vynaty_clen * (covDQ_s[h, i] - covQQ[h, i] - clen3_s) #záporné vždy
      abschyba_nv_i <- vynaty_clen * (covDQ_nv[h, i] - covQQ[h, i] - clen3_nv) #môže byť kladné
      
      cena_i_s <- abpriamky[1, i, h]+abpriamky[2, i, h]*mean(loads_h[,i]) -abpriamky[2,i,h]*kappaonshorewind2025[i]*EDteor_nv[1,i, h] - abpriamky[2,i, h]*(lambda/(1-lambda))*kappa_bezs*EDteor_s[1,i,h]
      mnozstvo_i_s <- ((lambda/(1-lambda))*kappa_bezs*EDteor_s[1,i,h])
      menovatel_s_i <-  cena_i_s * mnozstvo_i_s
      
      cena_i_nv <- abpriamky[1, i, h]+abpriamky[2, i, h]*mean(loads_h[,i]) -abpriamky[2,i,h]*(lambda/(1-lambda))*kappa_beznv*EDteor_nv[1,i, h] - abpriamky[2,i, h]*kappasolar2025[i]*EDteor_s[1,i,h]
      mnozstvo_i_nv <- ((lambda/(1-lambda))*kappa_beznv*EDteor_nv[1,i,h])
      menovatel_nv_i <-  cena_i_nv * mnozstvo_i_nv
      
      cov_s_relat_4[k, i, h] <- abschyba_s_i / menovatel_s_i
      cov_nv_relat_4[k, i, h] <- abschyba_nv_i / menovatel_nv_i
      
      #R_cov4 denne vynosy
      citatel_den_s <- citatel_den_s + abschyba_s_i
      menovatel_den_s <- menovatel_den_s + menovatel_s_i
      
      citatel_den_nv <- citatel_den_nv + abschyba_nv_i
      menovatel_den_nv <- menovatel_den_nv + menovatel_nv_i
      
      #vývoj E(PQ) cez lambda
      a <- abpriamky[1, i, h] * rep(1, 365)
      b <- abpriamky[2, i, h] * rep(1, 365)
      kappa_s <- (lambda*kappa_bezs)/(1-lambda)
      kappa_nv <- (lambda*kappa_beznv)/(1-lambda)
      #revenues_prax_4[k, i, h] <- mean((a+b*loads_h[, i] - b*CF_s_h[,i]*kappa_s- b*CF_nv_h[,i]*kappaonshorewind2025[i])*(CF_s_h[,i]*kappa_s)) #nizsie nez revenues_prax_1 -OK
      
      cenamnozstvo_h_4[,1] <- (a+b*loads_h[, i] - b*CF_s_h[,i]*kappa_s -b*CF_nv_h[, i]*kappaonshorewind2025[i]) #klesa
      cenamnozstvo_h_4[,2] <-(CF_s_h[,i]*kappa_s) #rastie
      revenues_teor_4_s[k, i, h] <- (mean(cenamnozstvo_h_4[,1])*mean(cenamnozstvo_h_4[,2])+abschyba_s_i) #/ kappa_s #nizsie nez revenues_teor_1- OK
      
      mnozstvo_nv <- (CF_nv_h[,i]*kappa_nv)
      revenues_teor_4_nv[k,i,h] <- (mean(cenamnozstvo_h_4[,1])*mean(mnozstvo_nv) + abschyba_nv_i)
      #skúška modelu, obe to isté
      #cov_skuska[k, i, h] <- cov(cenamnozstvo_h_4[,1], cenamnozstvo_h_4[,2])
      #abschyba_skuska[k, i, h] <- revenues_prax_4[k,i,h]-(mean(cenamnozstvo_h_4[,1])*mean(cenamnozstvo_h_4[,2]))
      
    R_cov_4_den_s[k,i] <- citatel_den_s / menovatel_den_s
    R_cov_4_den_nv[k,i] <- citatel_den_nv / menovatel_den_nv
    }}}

#vykreslenie R_cov4 solar a R_cov4 solar za deň
par(mfrow = c(3, 5)) 
X <-seq(from=10, by=3, length.out=15)
for (h in 6:20){
  plot(X, cov_s_relat_4[, 1, h], type = "l", lwd=1.5, col = "red", ylim = c(-1,0.05), 
       xlab="Kapacitný podiel %", ylab="Rcov 4",
       main = paste("h =", h-1))
  lines(X, cov_s_relat_4[, 2, h], col = "blue", lwd=1.5)
  lines(X, cov_s_relat_4[, 3, h], col = "green", lwd=1.5)
  lines(X, cov_s_relat_4[, 4, h], col = "orange", lwd=1.5) 
  if (h==6){
    legend("bottomleft", legend=c("Nemecko","Rakúsko","Estónsko","Litva"),
         col=c("red","blue","green","orange"), lty=1, lwd=1.7, cex = 0.9) }}

mtext(expression("Kapacitný podiel" ~ lambda[s] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(R[cov*","*h*","*s]), side = 2, outer = TRUE, line = 1, cex = 1.2)

#dev.off() #reset grafického okna
par(mfrow = c(1, 1))
plot(X, R_cov_4_den_s[, 1], type = "l", lwd = 1.8, col = "red", ylim = c(-1, 0.1), xlab="Trhový podiel %", ylab="R_{cov,4} denná")
lines(X, R_cov_4_den_s[, 2], col = "blue", lwd = 1.8)
lines(X, R_cov_4_den_s[, 3], col = "green", lwd = 1.8)
lines(X, R_cov_4_den_s[, 4], col = "orange", lwd = 1.8) 
legend("bottomleft", legend=c("Nemecko","Rakúsko","Estónsko","Litva"),
       col=c("red","blue","green","orange"), lty=1, lwd=1.9, cex = 1.5) 
mtext(expression("Kapacitný podiel" ~ lambda[s] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(R[cov*","*h]~"solar - deň" ), side = 2, outer = TRUE, line = 1, cex = 1.2)

#vykreslenie R_cov4 pre vietor a R_cov4 pre vietor za den
par(mfrow = c(4,6))
for (h in 1:24){
  plot(X, cov_nv_relat_4[, 1, h], type = "l", lwd= 1.5, col = "red",
       ylim = c(-1,0.05),
       main = paste("h =", h-1))
  lines(X, cov_nv_relat_4[, 2, h], col = "blue", lwd = 1.5)
  lines(X, cov_nv_relat_4[, 3, h], col = "green", lwd = 1.5)
  lines(X, cov_nv_relat_4[, 4, h], col = "orange", lwd = 1.5) 
  if (h==1){
    legend("bottomleft", legend=c("Nemecko","Rakúsko","Estónsko","Litva"),
         col=c("red","blue","green","orange"), lty=1, cex = 0.7) }}
mtext(expression("Kapacitný podiel" ~ lambda[nv] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(R[cov*","*h*","*nv] ), side = 2, outer = TRUE, line = 1, cex = 1.2)

par(mfrow = c(1, 1))
plot(X, R_cov_4_den_nv[, 1], type = "l", lwd = 1.8, col = "red", ylim = c(-1, 0.1), xlab="Trhový podiel %", ylab="R_{cov,4}")
lines(X, R_cov_4_den_nv[, 2], col = "blue", lwd = 1.8)
lines(X, R_cov_4_den_nv[, 3], col = "green", lwd = 1.8)
lines(X, R_cov_4_den_nv[, 4], col = "orange", lwd = 1.8) 
legend("bottomleft", legend=c("Nemecko","Rakúsko","Estónsko","Litva"),
       col=c("red","blue","green","orange"), lty=1, lwd=1.9, cex = 1.5) 
mtext(expression("Kapacitný podiel" ~ lambda[nv] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
mtext(expression(R[cov*","*h]~"vietor - deň" ), side = 2, outer = TRUE, line = 1, cex = 1.2)

#vykreslenie E(PQ)
#dev.off() reset grafického okna v prípade grafických problémov
par(mfrow = c(3, 5), mar = c(2, 2, 2, 1), oma = c(2.5, 3, 1, 1))
cols <- c("red", "blue", "green", "orange")
names <- c("Nemecko","Rakúsko","Estónsko","Litva")

aktlambdy <- c(
   (lambda_k_s_2025[1]+lambda_k_s_2026[1])/2,
   (lambda_k_s_2025[2]+lambda_k_s_2026[2])/2,
   (lambda_k_s_2025[3]+lambda_k_s_2026[3])/2,
   (lambda_k_s_2025[4]+lambda_k_s_2026[4])/2
)

for (i in 1:n_countries){
  for (h in 6:20){
    plot(X, revenues_teor_4_s[, i, h], type = "l", lwd = 1.8, col = cols[i],
       xlab="Kapacitný podiel %", ylab="revenues_prax", 
       main = paste("h =", h-1))
   
    #vykreslenie aktualnej lambda_s
    idx <- which.min(abs(X - aktlambdy[i]*100))
    
    points(X[idx],
           revenues_teor_4_s[idx, i, h],
           pch = 19,
           col = cols[i],
           cex = 1.3)
    
    if (h==6){
    legend("bottomleft", legend=names[i],
         col=cols[i], lty=1, cex = 1.4) }
    mtext(expression("Kapacitný podiel" ~ lambda[s] ~ "(%)"), side = 1, outer = TRUE, line = 1, cex = 1.2)
    mtext(expression(E(P[h]*Q[h*","*s])), side = 2, outer = TRUE, line = 1, cex = 1.2)
  }}
