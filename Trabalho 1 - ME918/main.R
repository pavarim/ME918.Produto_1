# pacotes utilizados
library(glue)
require(yaml)
require(jsonlite)

# lendo configuracoes
config <- read_yaml('configuracao.yaml')  # lendo configuracoes

# verificações
if (!(config$reutilizar_modelo %in% c('s', 'n'))) {
  stop('Especificacoes incorretas em reutilizar_modelo.')
}

# executando
if (config$reutilizar_modelo == 'n') source('treinamento.R')
source('predicao.R')
source('grafico.R')
