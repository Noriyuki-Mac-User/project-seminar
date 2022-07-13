#プロゼミ 発表会

# グラフの設定
ps.options(family = "Japan1GothicBBB", pointsize = 16)


#データ分析
library(car)
data <- read.csv("プロゼミ_変更後_ODA無.csv", header = TRUE, encoding = "UTF-8")[, 2:17]


#2020一人当たりGDP
data.null.lm <- lm(X2020一人当たりGDP ~ 1, data = data)
data.full.lm <- lm(X2020一人当たりGDP ~ ., data = data)

step(data.full.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))
step(data.null.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))

data.lm <- lm(X2020一人当たりGDP ~ X2019一人当たりGDP + X2019一人当たりDGP成長率 + X2019総貯蓄 + X2020総貯蓄, data = data)

summary(data.lm)
vif(data.lm)

plot(data.lm$fitted.values, data$X2020一人当たりGDP, xlim = c(0, 120000), ylim = c(0, 120000), xlab = "推定値", ylab = "観測値")
abline(data.lm)


#2020総貯蓄
data.null.lm <- lm(X2020総貯蓄 ~ 1, data = data)
data.full.lm <- lm(X2020総貯蓄 ~ ., data = data)

step(data.full.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))
step(data.null.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))

data.lm <- lm(X2020総貯蓄 ~ X2019総貯蓄 + X2020一人当たりDGP成長率, data = data)

summary(data.lm)
vif(data.lm)

plot(data.lm$fitted.values, data$X2020総貯蓄, xlab = "予測値", ylab = "観測値")
abline(data.lm)


#2020消費者物価上昇率
data.excluded <- data[-182, ]
data.excluded <- data.excluded[-148, ]
data.excluded <- data.excluded[-90, ]
data.null.lm <- lm(X2020消費者物価上昇率 ~ 1, data = data.excluded)
data.full.lm <- lm(X2020消費者物価上昇率 ~ ., data = data.excluded)

step(data.full.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))
step(data.null.lm, direction = "both", scope = list(lower = data.null.lm, upper = data.full.lm))

data.lm <- lm(X2020消費者物価上昇率 ~ X2019消費者物価上昇率 + X2019一人当たりGDP + X2019総貯蓄 + X2019GDPデフレーター + X2020GDP成長率 + X2020GDPデフレーター, data = data.excluded)
summary(data.lm)
vif(data.lm)

plot(data.lm$fitted.values, data.excluded$X2020消費者物価上昇率, xlab = "予測値", ylab = "観測値")
abline(data.lm)
