preditores <- fromJSON('entradas/preditores.json')  # lendo json
fit <- readRDS('saidas/fit.rds')  # lendo modelo

predicao_val <- predict(fit, newdata = preditores)

toJSON(predicao_val, path = 'saidas/predicao.json')
