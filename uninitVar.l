%{
#include "y.tab.h"
//#define YYSTYPE char*
extern YYSTYPE yylval;
%}
%%
main[\(][\)][ ]*[\{]					{ return INICIO_MAIN;}
[\}]								{ return FIM_MAIN;}
[=]								{ return IGUAL;}
[,]								{ return VIRGULA;}
(int)|(float)						{ return TIPO;}
[a-zA-Z]+[a-zA-Z0-9]*					{ yylval=strdup(yytext);
							  									return NOMEVAR;
}
																					[;]								{ return PONTO_VIRGULA;}
[0-9]+[\.][0-9]+						{ return VALOR;}
[0-9]+							{ return VALOR;}
[\(]								{ return PARENTESES_ESQ;}
[\)]								{ return PARENTESES_DIR;}
[\*]								{ return OPERA;}
[/]								{ return OPERA;}
[\-]								{ return OPERA;}
[\+]								{ return OPERA;}
[ \n]								;
%%
void yyerror (char const *s) {
   printf (stderr, "%s\n", s);
 }
 int yywrap(void) {
    return 1;
}