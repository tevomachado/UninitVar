%{
   #include <string.h>
   #include <stdio.h>
   #define YYSTYPE char *
   char varIniciadas[100][100];
   int i;
   
%}

%start				prog_fonte
%token			INICIO_MAIN FIM_MAIN TIPO PONTO_VIRGULA VIRGULA NOMEVAR IGUAL PARENTESES_ESQ PARENTESES_DIR OPERA VALOR
%right				IGUAL
%left				OPERA

%%

prog_fonte		:	INICIO_MAIN conteudo_prog FIM_MAIN {};

conteudo_prog	:	declaracoes expressoes
					;
			
declaracoes	: 	linha_declara declaracoes
				|			linha_declara
		|
		;

linha_declara	: 	TIPO variaveis PONTO_VIRGULA
		;

variaveis	:	identificador VIRGULA variaveis
		|			identificador
		;

identificador	:	NOMEVAR IGUAL VALOR 		{ int j=0;
								  								while(strcmp(varIniciadas[j],"\0")){ j++;}
											  								strcpy(varIniciadas[j],$1);
}
																|			NOMEVAR
		;

expressoes	:	linha_executavel expressoes
		|			linha_executavel
		|
		;

linha_executavel:	NOMEVAR IGUAL operacoes PONTO_VIRGULA	{ int j=0;
								  								while(strcmp(varIniciadas[j],"\0")){ j++;}
								  								strcpy(varIniciadas[j],$1);
}
													;
operacoes	:	operacoes OPERA operacoes
		|			PARENTESES_ESQ operacoes PARENTESES_DIR
		|			VALOR
		|			NOMEVAR			{ int j=0; int sim=0;
						  							for(j=0;j<100;j++){ 
						  								if (!strcmp(yylval,varIniciadas[j])){
sim=1;
break;
}
																													  							}
						  							if(!sim){
printf("warning: %s nao inicializada\n", yylval);
}
}


																																			;
%%
void main(){
	for(i=0;i<100;i++){
		varIniciadas[i][0]='\0';
	}
	yyparse();
}
