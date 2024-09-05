fit <- readRDS('saidas/fit.rds')  # lendo modelo


pdf('saidas/grafico_predicao.pdf', width = 7, height = 5)
plot(x = fit$fitted.values, y = fit$model[[1]],
     xlab = 'Preditos', ylab = 'Observados')
abline(v=predicao_val, lty = 9, col = rgb(0, 0, 0, alpha = 0.6))
dev.off()
