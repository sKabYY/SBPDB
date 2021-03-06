%{

#include "planner.h"
#include "ql.h"
#include "sm.h"
#include "gram.h"

%}

%option noyywrap

WS      [\r\ \t\b\f]
DIGIT   [0-9]
ID      [A-Za-z][_A-Za-z0-9]*

%x STR

%%

{WS}                    /* ignore whitespace */;
\n						printf("sbpdb> "); fflush(stdout);
\"                      BEGIN(STR);
<STR>{ID}               yylval.string = strdup(yytext); return STRING_V;
<STR>\"                 BEGIN(INITIAL);

{DIGIT}+                yylval.number = atoi(yytext); return NUMBER;
-{DIGIT}+               yylval.number = atoi(yytext); return NUMBER;
;                       return SEMICOLON;
\.                      return DOT;
\*                      return STAR;
show					return SHOW;
commit					return COMMIT;
rollback				return ROLLBACK;
databases				return DATABASES;
tables					return TABLES;
exit                    return EXIT;
help                    return HELP;
use						return USE;
create                  return CREATE;
drop                    return DROP;
database				return DATABASE;
table                   return TABLE;
view                    return VIEW;
select                  return SELECT;
from                    return FROM;
where                   return WHERE;
and                     return AND;
or                      return OR;
not                     return NOT;
as                      return AS;
in                      return IN;
insert                  return INSERT;
into                    return INTO;
set						return SET;
values                  return VALUES;
delete                  return DELETE;
update                  return UPDATE;
primary					return PRIMARY;
foreign					return FOREIGN;
references				return REFERENCES;
key						return KEY;
check					return CHECK;
int                     return INT_T;
string                  return STRING_T;
float                   return FLOAT_T;
{ID}                    yylval.string = strdup(yytext); return ID;
\(                      return LBRACE;
\)                      return RBRACE;
,                       return COMMA;
"="                     return EQ;
"<="                    return LE;
"<>"                    return NE;
"<"                     return LT;
">="                    return GE;
">"                     return GT;

%%
