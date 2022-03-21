/* Análise Estatística Primária de medidas para conujnto de dados de tempo de callcenter */
/* carregar o dataset*/
FILENAME REFILE '/home/u45180702/sasuser.v94/dataset.csv';

PROC IMPORT DATAFILE=REFILE DBMS=CSV OUT=WORK.dataset;
	GETNAMES=YES;
RUN;

/*1-Qual o tempo média de atendimento?*/
PROC means mean data=dataset;
	var tempo_telefone;
run;

/* 2-Qual a medianado tempo de atendimento?*/
PROC means median data=dataset;
	var tempo_telefone;
run;

/* 3-Qual o desvio padrão e variância do tempo de atendimento?*/
PROC means var std data=dataset;
	var tempo_telefone;
run;

/* 4-Quais os quartis e percentis 32, 57 e 98do tempo de atendimento?*/
PROC UNIVARIATE DATA=dataset NOPRINT;
	var tempo_telefone;
	output out=Pctls pctlpts=32 57 98 pctlpre=medida_ pctlname=pct32 pct 57 pct98;
run;

/* 5-Qual o intervalo interquartil do tempo de atendimento?*/
PROC means 	QRANGE data=dataset;
	var tempo_telefone;
run;

/* 6-Crie um boxplot que represente as medidas anteriores.*/
PROC SGPLOT data = dataset;
	vbox tempo_telefone;
run;


/* 7-A covariância de duas variáveis x e y em um conjunto de dados mede como
 as duas estão linearmente relacionadas. Uma covariância positiva indicaria uma 
 relação linear positiva entre as variáveis e uma covariância negativa indicaria
 o contrário.Calcule a covariância  entre  o  tempo  de atendimentoe  o  total 
 de  clientes.  O  que  o  resultado indica?*/
PROC CORR cov data=dataset;
	VAR tempo_telefone clientes;
run;

/* 8-Calcule a Frequência Absoluta da variável tempo de atendimento */
PROC FREQ  data=dataset;
	TABLE tempo_telefone;
run;

/* 9-Crie um histograma que represente sua resposta no item anterior */
PROC univariate data=dataset;
	 VAR tempo_telefone;
	 hist;
run;

/* 10-Calcule a Frequência Relativa e Acumuladadavariável tempode atendimento.*/
PROC FREQ data=dataset;
	TABLE tempo_telefone;
run;

/* 11-Crie um gráfico de linha para a Frequência Acumulada.*/

TITLE "Gráfico da Frequencia Acumulada";
ods graphics on;
PROC UNIVARIATE DATA= dataset NOPRINT;
	cdf tempo_telefone / normal;
run;

/* 12-Crie  um gráfico  de  dispersão  para  representar  a  relação  entre  as  duasvariáveis  no dataset*/
TITLE "Gráfico da dispersão";
PROC SGPLOT DATA= dataset;
	scatter X=tempo_telefone Y=clientes;
run;










