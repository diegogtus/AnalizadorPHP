/*IMPORTACIONES*/
package sintacticAnalizer;
import static sintacticAnalizer.Token.*;

//DEFINICIONES
%%
%class Lex
%type Token
L=[a-zA-Z_]
D=[0-9]
ASCI=[\x00-\xff]
ASCII=[a-zA-Z_\x7f-\xff]
ASCIIN=[a-zA-Z0-9_\x7f-\xff]
DECIMAL= [1-9][0-9]*| 0
HEXADECIMAL= 0[xX][0-9a-fA-F]+
OCTAL = 0[0-7]+
BINARI = 0b[01]+
PUNT="("|")"|"["|"]"|"\;"|"."|","|"{"|"}"
WHITE=[ \t\r\n]
COMMENT = "/*" [^*] ~"*/" | "/*" "*"+ "/"
RESERVED ="<?php"| "?>" | "__halt_compiler()" | "abstract" | "and" | "array()" |
    "as" | "break" | "callable" | "case" | "catch" | "class" | "clone" | "const" |
    "continue" | "declare" | "default" | "die()" | "do" | "echo" | "else" | "elseif" 
   | "empty()" | "enddeclare" | "endfor" | "endforeach" | "endif" | "endswitch" | 
   "endwhile"| "eval()" | "exit()" | "extends" | "final" | "finally" | "for" |
    "foreach" | "function" | "global" | "goto"  | "if" | "implements" | "include" |
    "include_once" | "instanceof" | "insteadof" | "interface" | "isset()" | 
   "list()"| "namespace" | "new" | "or" | "prin" | "private" | "protected" | 
   "public" | "require" | "require_once" | "return" | "static" | "switch" |
    "throw" | "trait" | "try" | "unset()" | "use" | "while" | "xor" | "yield" 
TYPE = "String" | "Integer" | "Float" | "Boolean" | "Array" | "Object" | "NULL"
    | "Resource"
ARITMETIC_OPERATOR = "+" | "-" | "*" | "/" | "%" | "**" 
LOGIC_OPERATOR = "and" | "or" | "xor" | "!" | "&&" |"||" | "<" | ">" | "!=" | "==" |
    "=" | "<>"
CONTROL = "if"|"then"|"else"|"While"|"Do"|"while"|"For"|"Foreach"|"Break"|
    "Switch"|"Include"|"continue"|"return"
PRE_VAR="Superglobals"|"$GLOBALS"|"$_SERVER"|"$_GET"|"$_POST"|"$_FILES"|"$_REQUEST"
    |"$_SESSION"|"$_ENV"|"$_COOKIE"|"$php_errormsg"|"$HTTP_RAW_POST_DATA"
    |"$http_response_header"|"$argc"|"$argv" 
%{
    public String lexeme;
%}
%%

//EXPRESIONES

{RESERVED}+ {lexeme=yytext(); return RESERVED;}
{ARITMETIC_OPERATOR} {lexeme=yytext(); return ARITMETIC_OPERATOR;}
{LOGIC_OPERATOR}+ {lexeme=yytext(); return LOGIC_OPERATOR;}
"True" | "False" {lexeme=yytext(); return BOOLEAN;}
[+-]?{DECIMAL}| [+-]?{HEXADECIMAL}| [+-]?{OCTAL}| [+-]?{BINARI} {lexeme=yytext(); return INT;}
[+-]?(({D}+ | ({D}*"\."{D}+) | ({D}+"\."{D}*)) [eE]?[+-]? {D}+) {lexeme=yytext(); return FLOAT;}
"\"".*"\"" {lexeme=yytext(); return STRING;}
"\'".*"\'" {lexeme=yytext(); return STRING;}
{ASCII}{ASCIIN}* {lexeme=yytext(); return ID;}
"$"{ASCII}{ASCIIN}* {lexeme=yytext(); return VAR;}
("define(\'"({ASCII}{ASCIIN}*)",""\"".*"\")") {lexeme=yytext(); return CONSTANT;}
{CONTROL} {lexeme=yytext(); return CONTROL_VAR;}
{PRE_VAR} {lexeme=yytext(); return PREDEFINE_VAR;}
{ASCII}{ASCIIN}*"(" {lexeme=yytext(); return FUNCTION;}
("//".*)|("/*".*"*/")|("*".*)|("/*".*)|(.*"*/") {lexeme=yytext(); return COMMENT;}
{WHITE} {/*Ignore*/}
{WHITE}?{PUNT}{WHITE}? {lexeme=yytext(); return PUNTUACTION;}
. {return ERROR;}


