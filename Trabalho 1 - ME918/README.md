
# PredModel
## Introdução


O Projeto PredModel oferece um pipeline automatizado para o treinamento, predição e análise gráfica de modelos de regressão linear e logística. Este guia descreve a estrutura dos arquivos do projeto, suas funcionalidades, e fornece um passo a passo para seu uso eficaz.

A estrutura do projeto é composta pelos seguintes diretórios e arquivos:

- `entradas/`: pasta com arquivos de entrada, isto é, o banco de dados e
  arquivo com valores a serem preditos pelo modelo;
- `saidas/`: psata com os arquivos gerados (modelos, gráficos e
  predições);
- `R/`: pasta contendo os *scripts*:
  - `treinamento.R`: Arquivo responsável por armazenar a estrutura completa dos códigos relacionados ao treinamento dos modelos. Isso inclui a preparação dos dados, a configuração dos hiperparâmetros e a execução do processo de treinamento;
  - `predicao.R`: Arquivo responsável por armazenar a estrutura dos códigos utilizados para realizar a predição com os modelos treinados. Inclui a preparação dos dados de entrada, a execução das predições e a geração dos resultados finais;
  - `grafico.R`: Arquivo destinado para gerar o gráfico da predição para o conjunto de variáveis;
- `main.R`: Arquivo responsável pela execução completa do projeto, passando por todos os scripts necessários;
- `README.md`: arquivo de documentação;
- `configuracao.yaml`: Define as configurações necessárias para a realização das regressões. 

## Requisitos

Para executar o projeto corretamente, é necessário que o usuário tenha:

- - Linguagem de programação R, versão 4.3.2 ou compatível;
- Um arquivo `configuracao.yaml` que define os parâmetros para a
  execução do pipeline;
- Um conjunto de dados no formato `csv` localizado na pasta `entradas/`;
- Um arquivo `preditores.json` contendo os valores das variáveis
  preditoras, que será utilizado para gerar as predições localizado na
  pasta `entradas/`.

## Arquivo de Configuração e Predição

O arquivo `configuracao.yaml` é utilizado para especificar os parâmetros
de entrada do produto, como o nome do banco de dados, o tipo de modelo a
ser ajustado, as variáveis preditoras e a variável resposta. As
configurações a serem fornecidas devem ser as seguintes:

- `tabela`: nome do arquivo de dados no formato `csv`, o qual contém as
  observações a serem utilizadas no treinamento;
- `modelo`: dever ser `reg_linear` para ajustar uma regressão linear ou
  `reg_logstica` para ajustar uma regressão logística;
- `reutilizar_modelo`: deve ser `sim` para quando deseja-se reutilizar
  um modelo anteriormente ajustado ou `nao` caso o objetivo seja ajustar
  um novo modelo. Os modelos ajustados são salvos na pasta `saídas/`;
- `escolhe_modelo`: Deve especificar qual modelo será uttilizado para
  fazer predição. Caso nenhum modelo seja escolhido, será utilizado
  `fit1`;
- `pares`: deve conter uma lista de blocos. Cada bloco é um conjunto de
  pares chave-valor, os quais geram arquivos com o sufixo `.rds`.
  Ademais, para preditores categóricos, não utilizar valores numéricos
  na sua identificação. Cada bloco deve conter:
  - `"y"`: a variável resposta;
  - `"x"`: as variáveis preditoras.

A seguir, temos um exemplo de como o arquivo `configuracoes.yaml` deve
ser estruturado, utilizando o conjunto de dados `mtcars`, para fazer uma
regressão logística utilizando `vs` como variável resposta e `wt` como
preditora:

``` yaml
tabela: mtcars.csv
modelo: reg_logistica
reutilizar_modelo: nao
escolhe_modelo: fit1
pares:
  - "y": vs
    "x": [wt]
```

Além disso, para fazer predição com dois conujuntos de preditores, temos
que o arquivo `preditores.json` deve ser configrado como:

``` json
[
  {"wt":1,"drat":3},
  {"wt":1,"drat":5}
]
```

## Execução do Produto

O produto pode ser executado através do script `main.R`, que faz a
integração das três partes principais: treinamento, predição e geração
de gráficos. Para executar o produto abra o Windows PowerShell e
encontre o executável `Rscript.exe` (normalmente ele fica na pasta
sinalizada abaixo), após isso execute o comando:

    & 'C:\Program Files\R\R-4.3.2\bin\x64\Rscript.exe' main.R

Além disso, de forma alternativa, é possível executar o produto por meio
do `R`, sendo necessário abrir o `R` e utilizar o seguinte comando no
console:

``` r
source('main.R')
```

<!-- O script `main.R` realiza as seguintes etapas: -->
<!-- - Se `reutilizar_modelo for nao, ele ajusta o modelo especificado no arquivo configuracao.yaml, utilizando o arquivo de dados fornecido, e salva o modelo ajustado na pasta saidas; -->
<!-- - Executa o script predicao.R, que gera predições com base no modelo ajustado e nas variáveis preditoras fornecidas no arquivo preditores.json; -->
<!-- - Executa o script grafico.R, que gera um gráfico comparando os valores observados e preditos e salva esse gráfico na pasta saidas. -->

## Resultados

Após a execução do pipeline, o PredModel gera automaticamente os seguintes arquivos na pasta `saidas/`:

- Modelos ajustados, com sufixo `.rds` (e.g. `fit1.rds`);
- Arquivo de predição com sufixo `.json` contendo as predições geradas
  pelo modelo escolhido (e.g. `fit1_predicao.json`);
- Um gráfico comparando os valores observados e preditos identificando o
  modelo escolhido salvo em formato `.pdf`
  (e.g. `fit1_predito_observado.pdf`);
- Um QQPlot identificando o modelo escolhido em formato `.pdf`
  (e.g. `fit1_QQplot.pdf`).

## Exemplos

1.  Regressão Lienar

Utilizando o banco de dados `mtcars`, disponível na base do `R`, para
ajustar um modelo de regressão linear com `mpg` como variável resposta e
as preditoras `wt` e `drat` basta ajustar o arquivo `configuracoes.yaml`
da seguinte forma:

``` yaml
tabela: mtcars.csv
modelo: reg_linear
reutilizar_modelo: nao
escolhe_modelo: fit1
pares:
  - "y": mpg
    "x": [wt, drat]
```

Ademais, no arquivo `preditores.json` é necessário colocar os valores em
que se deseja utilizar o modelo para predição, por exemplo:

``` json
[
  {"wt":1,"drat":3},
  {"wt":1,"drat":5}
]
```

2.  Regressão Logística

Utilizando o banco de dados `mtcars`, disponível na base do `R`, para
ajustar dois modelos de regressão logística com `vs` como variável
resposta e `wt`, para o primeiro modelo, e `mpg` e `drat`, para o
segundo modelo, como variáveis preditoras basta ajustar o arquivo
`configuracoes.yaml` da seguinte forma:

``` yaml
tabela: mtcars.csv
modelo: reg_logistica
reutilizar_modelo: nao
escolhe_modelo: fit2
pares:
  - "y": vs
    "x": [wt]
  - "y": vs
    "x": [mpg, drat]
```

Além disso, é necessário escolher qual modelo deve ser feita a predição,
note que neste caso foi selecionado o segundo modelo ajustado (`fit2`).
Além disso, para fazer predições para dois conjuntos de preditores,
temos que o arquivo `preditores.json` deve ser configurado como:

``` json
[
  {"mpg":18,"drat":3},
  {"mpg":20,"drat":5}
]
```
