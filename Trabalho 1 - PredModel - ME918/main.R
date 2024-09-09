# renv
renv::restore()

# pacotes utilizados
library(glue)
library(yaml)
library(jsonlite)
library(ggplot2)
library(farver)

config <- read_yaml('configuracao.yaml')  # lendo configuracoes

# executando
if (config$reutilizar_modelo %in% c('não', 'nao')) source('R/treinamento.R')
source('R/predicao.R')
source('R/grafico.R')
