db <- read.csv(glue('entradas/{config$tabela}'))  # lendo banco de dados

formulas <- reformulate(paste(config$pares[[1]]$x, collapse = ' + '),
                        response = config$pares[[1]]$y)

if (config$modelo == 'reg_linear') {
  # regressao linear
  fit <- lm(formulas, data = db)
  
} else if (config$modelo == 'reg_logistica') {
  # regressao logistica
  fit <- glm(formulas, data = db, family = binomial)

} else {
  stop('Especificações de modelo incorretas, usar reg_linear ou reg_logistica')
}

saveRDS(fit, file = 'saidas/fit.rds')  # salvando modelo
