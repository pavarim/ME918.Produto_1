Documentação do Projeto de Predição
================

# Introdução

Este projeto foi desenvolvido para criar um pipeline automatizado que
integra treinamento, predição e análise gráfica de modelos de regressão
linear ou logística. O produto é configurável, adaptando-se facilmente a
diferentes conjuntos de dados e configurações, com base em um arquivo de
configuração no formato YAML.

A estrutura do projeto é composta pelos seguintes diretórios e arquivos:

- `entradas/`: Arquivos de entrada, o que incluem o banco de dados,
  arquivo de configurações e arquivo com valores a serem preditos pelo
  modelo;
- `saidas/`: Arquivos gerados (modelos, gráficos, etc.);
- `treinamento.R`: Script de treinamento do modelo;
- `predicao.R`: Script de predição do modelo;
- `grafico.R`: Script de análise gráfica;
- `configuracao.yaml`: Arquivo de configuração;
- `README.Rmd`: Arquivo de documentação;
- `main.R`: Script principal que integra todas as partes.

# Requisitos

Para executar o projeto corretamente, é necessário ter o seguinte
ambiente configurado:

``` r
install.packages(c("glue", "yaml", "jsonlite", "nnet", "usethis"))
```

Além disso, o usuário precisa fornecer:

- Um arquivo de configuração no formato YAML, denominado
  `configuracao.yaml`, que define os parâmetros para a execução do
  pipeline.
- Um conjunto de dados no formato CSV localizado na pasta entradas.
- Um arquivo JSON contendo os valores das variáveis preditoras, que será
  utilizado para gerar predições no script de predição, também
  localizado na pasta entradas.

# Arquivo de Configuração

O arquivo configuracao.yaml é utilizado para especificar os parâmetros
de entrada do produto, como o nome do banco de dados, o tipo de modelo a
ser ajustado, as variáveis preditoras e a variável resposta. As
configurações a serem fornecidas devem ser as seguintes:

- `tabela`: identificar o banco de dados;
- `modelo`: dever ser `reg_linear` para ajustar uma regressão linear ou
  `reg_logstica` para ajustar uma regressão logística;
- `reutilizar_modelo`: deve ser `sim` ou `nao`. Identifica se deve ser
  ajustado um novo modelo, útil para quanto o modelo ja está ajustado,
  não havendo necessidade de ajusta-lo novamente para fazer predições;
- `escolhe_modelo`: Deve serpecificar qual modelo será uttilizado para
  fazer predição. Caso nenhum modelo seja escolhido, será utilizado
  `fit1`.
- `pares`: deve conter uma lista com blocos. Cada bloco deve ter uma
  chave `"y"` identificando a variável resposta e uma chave `"x"`
  identificando as variáveis preditoras. É possível ajustar mais de um
  modelo com apenas uma execução. Para cada bloco, é gerado um objeto
  .RDS nomeado por fit seguido de um número, começando em 1.

A seguir, temos um exemplo de como esse arquivo deve ser estruturado,
para uma regressão logística utilizando o conjunto de dados `mtcars` e
as variáveis `am`, como resposta, e `wt` e `cyl` como preditoras:

``` r
tabela: mtcars.csv

modelo: reg_logistica

reutilizar_modelo: nao

escolhe_modelo: fit1

pares:
  - "y": am
    "x": [wt, cyl]
```

- tabela: Nome do arquivo de dados no formato CSV que contém as
  observações a serem utilizadas no treinamento. O arquivo deve estar
  localizado na pasta entradas.

- modelo: Especifica o tipo de modelo a ser ajustado. As opções
  possíveis são:

  - reg_linear - Para ajustar um modelo de regressão linear.
  - reg_logistica - Para ajustar um modelo de regressão logística.

- reutilizar_modelo: Indica se um modelo previamente ajustado deve ser
  reutilizado ou se um novo modelo deve ser treinado. As opções são sim
  (reutiliza) ou nao (treina novamente).

- escolhe_modelo: Nome do arquivo de modelo salvo na pasta saidas a ser
  utilizado para predições. Apenas relevante se reutilizar_modelo for
  sim. pares: Define a variável resposta (y) e as variáveis
  preditoras (x) para o ajuste do modelo.

# Execucao do Produto

O produto pode ser executado através do script main.R, que faz a
integração das três partes principais: treinamento, predição e geração
de gráficos. Para executar o produto abra o

``` r
ADICIONAR FORMA DE FAZER PELO POWER SHELL]
```

Para executar o produto, abra o R e utilize o seguinte comando no
console:

``` r
source('main.R')
```

O script main.R realiza as seguintes etapas:

- Se reutilizar_modelo for nao, ele ajusta o modelo especificado no
  arquivo configuracao.yaml, utilizando o arquivo de dados fornecido, e
  salva o modelo ajustado na pasta saidas.

- Executa o script predicao.R, que gera predições com base no modelo
  ajustado e nas variáveis preditoras fornecidas no arquivo
  preditores.json.

- Executa o script grafico.R, que gera um gráfico comparando os valores
  observados e preditos e salva esse gráfico na pasta saidas.

# Resultados

Ao final da execução, os seguintes arquivos serão gerados na pasta
saidas:

- O modelo ajustado salvo na pasta saidas, no formato .rds.
- Arquivo .json contendo as predições geradas pelo modelo.
- Um gráfico comparando os valores observados e preditos, salvo na pasta
  saidas em formato .pdf.
