
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
- `main.R`: Script principal que integra todas as partes;
- `README.md`: Arquivo de documentação;
- `configuracao.yaml`: Arquivo de configuração.

# Requisitos

Para executar o projeto corretamente, é necessário que o usuário
forneça:

- Um arquivo de configuração no formato YAML, denominado
  `configuracao.yaml`, que define os parâmetros para a execução do
  pipeline.
- Um conjunto de dados no formato CSV localizado na pasta `entradas/`;
- Um arquivo `preditores.json` contendo os valores das variáveis
  preditoras, que será utilizado para gerar as predições, também
  localizado na pasta `entradas/`.

# Arquivo de Configuração e Predição

O arquivo `configuracao.yaml` é utilizado para especificar os parâmetros
de entrada do produto, como o nome do banco de dados, o tipo de modelo a
ser ajustado, as variáveis preditoras e a variável resposta. As
configurações a serem fornecidas devem ser as seguintes:

- `tabela`: nome do arquivo de dados no formato CSV, o qual contém as
  observações a serem utilizadas no treinamento. O banco de dados deve
  estar na pasta `entradas/`;
- `modelo`: dever ser `reg_linear` para ajustar uma regressão linear ou
  `reg_logstica` para ajustar uma regressão logística;
- `reutilizar_modelo`: deve ser `sim` para quando deseja-se reutilizar
  um modelo anteriormente ajustado ou `nao` caso o objetivo seja ajustar
  um novo modelo. Os modelos ajustados são salvos na pasta `saídas/`;
- `escolhe_modelo`: Deve especificar qual modelo será uttilizado para
  fazer predição. Caso nenhum modelo seja escolhido, será utilizado
  `fit1`.
- `pares`: deve conter uma lista com blocos. Cada bloco deve ter uma
  chave `"y"` identificando a variável resposta e uma chave `"x"`
  identificando as variáveis preditoras. É possível ajustar mais de um
  modelo com apenas uma execução. Para cada bloco, é gerado um objeto
  .RDS nomeado por fit seguido de um número, começando em 1. Para
  preditores categóricos, não utilizar valores numéricos na sua
  identificação.

A seguir, temos um exemplo de como o arquivo `configuracoes.yaml` deve
ser estruturado, utilizando o conjunto de dados `mtcars`, para fazer
duas regressões logística utilizando `vs` como variável resposta e `wt`,
para o primeiro modelo, e `wt` e `cyl` para o segundo:

``` r
tabela: mtcars.csv
modelo: reg_logistica
reutilizar_modelo: nao
escolhe_modelo: fit2
pares:
  - "y": vs
    "x": [wt]
  - "y": vs
    "x": [wt, drat]
```

Além disso, é necessário escolher para qual modelo deve ser feita a
predição, tal configuração deve ser especificada no arquivo
`predicao.json`. Considerando o segundo modelo ajustado (`fit2`) e o
interesse em fazer predição para 2 conjuntos de preditores, temos que o
arquivo é dado por:

``` r
[
  {"wt":1,"drat":3},
  {"wt":1,"drat":5}
]
```

# Execucao do Produto

O produto pode ser executado através do script `main.R`, que faz a
integração das três partes principais: treinamento, predição e geração
de gráficos. Para executar o produto abra o Windows PowerShell e
encontre o executável `Rscript.exe` (normalmente ele fica na pasta
sinalizada abaixo), após isso execute o comando:

    & 'C:\Program Files\R\R-4.3.2\bin\x64\Rscript.exe' main.R

Além disso, de forma alternativa, é possível executar o produto por meio
do R, sendo necessário abrir o R e utilizar o seguinte comando no
console:

``` r
source('main.R')
```

O script `main.R` realiza as seguintes etapas:

- Se reutilizar_modelo for nao, ele ajusta o modelo especificado no
  arquivo configuracao.yaml, utilizando o arquivo de dados fornecido, e
  salva o modelo ajustado na pasta saidas;
- Executa o script predicao.R, que gera predições com base no modelo
  ajustado e nas variáveis preditoras fornecidas no arquivo
  preditores.json;
- Executa o script grafico.R, que gera um gráfico comparando os valores
  observados e preditos e salva esse gráfico na pasta saidas.

# Resultados

Ao final da execução, os seguintes arquivos serão gerados na pasta
saidas:

- O modelo ajustado salvo na pasta saidas, no formato .rds.
- Arquivo .json contendo as predições geradas pelo modelo.
- Um gráfico comparando os valores observados e preditos, salvo na pasta
  saidas em formato .pdf.
