%{
#include <stdio.h>

int yyerror(char *s) {
    fprintf(stdout, "Error: %s\n", s);
    return 1;
}

%}
%union {
    double rmass;
    int count;
}
%token <rmass> ELEMENT
%token <count> COUNT
%left LF
%left LP LB
%right RP RB ADD
%type <rmass> chemical_expr chemgrps chemicals subchems total gnd
%%
gnd
        : total LF {
            printf("%.3f\n", $1);
            $$ = 0.0;
        }
        | gnd total LF {
            printf("%.3f\n", $2);
            $$ = 0.0;
        }
        ;
total
        : subchems
        | total ADD subchems
        {
            $$ = $1 + $3;
        }
        ;
subchems
        : chemicals
        | subchems ADD chemicals
        {
            $$ = $1 + $3;
        }
        | subchems ADD COUNT chemicals
        {
            $$ = $1 + $4 * $3;
        }
        ;
chemicals
        : chemgrps
        | LP chemgrps RP
        {
            $$ = $2 * 1;
        }
        | LB chemicals RB
        {
            $$ = $2 * 1;
        }
        | LP chemgrps RP COUNT
        {
            $$ = $2 * $4;
        }
        | LB chemicals RB COUNT
        {
            $$ = $2 * $4;
        }
        ;
chemgrps
        : chemical_expr
        | chemgrps chemical_expr
        {
            $$ = $1 + $2;
        }
        ;
chemical_expr
        : ELEMENT
        {
            $$ = $1 * 1;
        }
        | ELEMENT COUNT
        {
            $$ = $1 * $2;
        }
        ;
%%
int main(void) {
    yyparse();
    return 0;
}
