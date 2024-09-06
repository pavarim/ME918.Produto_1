if (is.null(config$escolhe_modelo)) {
  config$escolhe_modelo <- 'fit1'
}

fit <- readRDS(glue('saidas/{config$escolhe_modelo}.rds'))  # lendo modelo

preditores <- fromJSON('entradas/preditores.json')          # lendo json

predicao_val <- predict(fit, newdata = preditores, type = 'response')

write(toJSON(predicao_val), file = glue('saidas/{config$escolhe_modelo}_predicao.json'))
