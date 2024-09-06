db <- read.csv(glue('entradas/{config$tabela}'), stringsAsFactors = T)  # lendo banco de dados

for (i in 1:length(config$pares)) {
  formulas <- reformulate(paste(config$pares[[i]]$x, collapse = ' + '),
                          response = config$pares[[i]]$y)
  
  if (config$modelo == 'reg_linear') {
    # regressao linear
    fit <- lm(formulas, data = db)
    
  } else if (config$modelo == 'reg_logistica') {
    # regressao logistica
    fit <- glm(formulas, data = db, family = binomial)
    
  } else {
    stop('Especificações de modelo incorretas, usar
         reg_linear ou reg_logistica.')
  }
  saveRDS(fit, file = glue('saidas/fit{i}.rds'))  # salvando modelo
}
