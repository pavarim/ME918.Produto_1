if (is.null(config$escolhe_modelo)) {
  config$escolhe_modelo <- 'fit1'
}

fit <- readRDS(glue('saidas/{config$escolhe_modelo}.rds'))  # lendo modelo

db <- data.frame('x' = fit$fitted.values, 'y' = fit$model[[1]])

grafico <- ggplot(aes(x = x, y = y), data = db) +
  geom_point(size = 2) +
  geom_vline(xintercept = predicao_val, linetype = 'dashed',
             linewidth = 0.8, color = '#7f7f7f') +
  labs(x = 'Valores Preditos', y = 'Valores Observados') +
  theme_bw()

ggsave(glue('saidas/{config$escolhe_modelo}_predito_observado.pdf'), grafico,
       device = 'pdf', width = 8)


qqplot <- ggplot(aes(sample = residuals(fit)), data = db) +
  stat_qq(col = 'blue') +
  stat_qq_line(col = 'red') +
  labs(x = 'Quantil Teórico', y = 'Quantil Amostral') +
  theme_bw()

ggsave(glue('saidas/{config$escolhe_modelo}_QQplot.pdf'), qqplot,
       device = 'pdf', width = 8)