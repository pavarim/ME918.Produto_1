# renv
renv::restore()

# pacotes utilizados
library(glue)
library(yaml)
library(jsonlite)
library(ggplot2)

config <- read_yaml('configuracao.yaml')  # lendo configuracoes

# executando
if (config$reutilizar_modelo %in% c('não', 'nao')) source('treinamento.R')
source('predicao.R')
source('grafico.R')
