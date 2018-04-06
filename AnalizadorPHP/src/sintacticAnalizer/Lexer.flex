/*IMPORTACIONES*/
package sintacticAnalizer;
import static sintacticAnalizer.Token.*;

//DEFINICIONES
%%
%class Lex
%type Token
L=[a-zA-Z_]
D=[0-9]
ASCII=[a-zA-Z_\x7f-\xff]
ASCIIN=[a-zA-Z0-9_\x7f-\xff]
DECIMAL= [1-9][0-9]*| 0
HEXADECIMAL= 0[xX][0-9a-fA-F]+
OCTAL = 0[0-7]+
BINARI = 0b[01]+

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
LOGIC_OPERATOR = "and" | "or" | "xor" | "!" | "&&" |"||"
%{
    public String lexeme;
%}
%%

//EXPRESIONES

{RESERVED}+ {lexeme=yytext(); return RESERVED;}
{ARITMETIC_OPERATOR}+ {lexeme=yytext(); return ARITMETIC_OPERATOR;}
{LOGIC_OPERATOR}+ {lexeme=yytext(); return LOGIC_OPERATOR;}
"True" | "False" {lexeme=yytext(); return BOOLEAN;}
[+-]?{DECIMAL}| [+-]?{HEXADECIMAL}| [+-]?{OCTAL}| [+-]?{BINARI} {lexeme=yytext(); return INT;}
[+-]?(({D}+ | ({D}*"\."{D}+) | ({D}+"\."{D}*)) [eE]?[+-]? {D}+) {lexeme=yytext(); return FLOAT;}
("\"" | "\'") (({ASCIIN}{WHITE})|{ASCIIN})* ("\"" | "\'")  {lexeme=yytext(); return STRING;}

^{ASCII}{ASCIIN}* {lexeme=yytext(); return ID;}
"$"{ASCII}{ASCIIN}* {lexeme=yytext(); return VAR;}

{TYPE}+ {lexeme=yytext(); return TYPE;}
{WHITE} {/*Ignore*/}
"//".* {/*Ignore*/}
{COMMENT} {/*Ignore*/}
"\"" {return DOUBLE_QUOTE;}
. {return ERROR;}



