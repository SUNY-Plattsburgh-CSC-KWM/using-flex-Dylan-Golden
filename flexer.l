%{
#include <stdio.h>
#include <stdlib.h>

typedef enum {
    T_ID = 256,   
    T_INT,
    T_VAR,
    T_EQ,
    T_PLUS,
    T_TIMES,
    T_LPAREN,
    T_RPAREN,
    T_EOL,
    T_ERROR
} TokenType;


    
%}

%option noyywrap
%option nounput
%option noinput


DIGIT      [0-9]
INT        {DIGIT}+
VAR        [a-z][a-z0-9]{0,7}
WS         [ \t\r]+

%%

[ \t\r]+               

\n+                    { printf("EOL\n"); }

"="                    { printf("EQ(=)\n"); }
"+"                    { printf("PLUS(+)\n"); }
"*"                    { printf("TIMES(*)\n"); }
"("                    { printf("LPAREN(()\n"); }
")"                    { printf("RPAREN())\n"); }

{INT}                  { printf("INT(%s)\n", yytext); }
{VAR}                  { printf("VAR(%s)\n", yytext); }

.                      { printf("ERROR(%s)\n", yytext); }


%%

int main(int argc, char **argv)
{
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            perror("fopen");
            return 1;
        }
        yyin = f;
    }
    yylex();
    return 0;
}
