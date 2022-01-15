%{
#include <stdio.h>
#include "y.tab.h"

double getrmass(char* name);
%}
name            [A-Z][a-z]?
count           [0-9]+
%%
{name}          {
    yylval.rmass = getrmass(yytext);
    return ELEMENT;
}
{count}         {
    yylval.count = atoi(yytext);
    return COUNT;
}
"."             return ADD;
"("             return LP;
")"             return RP;
"["             return LB;
"]"             return RB;
\n              return LF;
%%
// int main() {
//     yylex(); /* 进行Lex分析 */
//     return 0;
// }

int yywrap() {
    return 1;
}
