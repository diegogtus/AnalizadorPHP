/*IMPORTACIONES*/
import static sintacticAnalizer.Token.*;

//DEFINICIONES
%%
%class Lex
%type Token
L=[a-zA-Z_]
D=[0-9]
white=[ \t\r\n]
COMMENT = "/*" [^*] ~"*/" | "/*" "*"+ "/"
RESERVED ="<?php" | "__halt_compiler()" | "abstract" | "and" | "array()" | "as" | "break" | "callable" | "case" | "catch" | "class" | "clone" | "const" | "continue" | "declare" | "default" | "die()" | "do" | "echo" | "else" | "elseif" | "empty()" | "enddeclare" | "endfor" | "endforeach" | "endif" | "endswitch" | "endwhile"| "eval()" | "exit()" | "extends" | "final" | "finally" | "for" | "foreach" | "function" | "global" | "goto"  | "if" | "implements" | "include" | "include_once" | "instanceof" | "insteadof" | "interface" | "isset()" | "list()"| "namespace" | "new" | "or" | "prin" | "private" | "protected" | "public" | "require" | "require_once" | "return" | "static" | "switch" | "throw" | "trait" | "try" | "unset()" | "use" | "while" | "xor" | "yield" 
TYPE = "String" | "Integer" | "Float" | "Boolean" | "Array" | "Object" | "NULL" | "Resource"
%{
    public String lexeme;
%}
%%

//EXPRESIONES

{RESERVED}+ {lexeme=yytext(); return RESERVED;}
{TYPE}+ {lexeme=yytext(); return TYPE;}
{L}({L}|{D})* {lexeme=yytext(); return ID;}
[-+]?{D}+ {lexeme=yytext(); return INT;}
"$" {return VAR;}
/*"define("{L}({L}|{D})*"),"({L}({L}|{D})*) | [-+]?{D}+" {lexeme==yytext(); return CONSTANT;}*/
"=" {return ASSIGN;}
"==" {return EQUALS;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLE;}
"/" {return DIVIDED;}
"!" {return NOT;}
"&&" {return AND;}
"||" {return OR;}
{white} {/*Ignore*/}
"//".* {/*Ignore*/}
{COMMENT} {/*Ignore*/}
"," {return COMMA;}
";" {return SEMICOLON;}
"\"" {return DOUBLE_QUOTE;}
. {return ERROR;}



