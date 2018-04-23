// inicio user code

// incluir el paquete
package cr.ac.ucr.ci1322.kaguro;

import java_cup.runtime.*;

%% // fin de user code, inicio de options and declarations

%public
%class GramaticaGrike
%standalone

%unicode

// IMPORTANT!!! CUP compatibility
%cup
%eofval{
    return new Symbol(GrikeSym.EOF);
%eofval}


%{
    /* Imprime yytext() seguido de un espacio y el mensaje */
    void printyytext(String message) {
        String text = yytext().replaceAll("\n", "");
        // se necesita para diferentes codificaciones de archivos de texto
        text = text.replaceAll("\r", "");
        System.out.println(text + ' ' + message);
    }

    int getSymIndex(String name) {
        for (int i = 2; i < GrikeSym.terminalNames.length; ++i) {
            if (name.equals(GrikeSym.terminalNames[i])) {
                System.out.println(GrikeSym.terminalNames[i]);
                return i;
            }
        }
        // returns error if not found
        return 0;
    }
    // retorna el Symbol para el tipo de token encontrado con sus coordenadas.
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
    // retorna el Symbol para el tipo de token encontrado, junto a su valor y sus coordenadas
    private Symbol symbol(int type, Object value){
            return new Symbol(type, yyline, yycolumn, value);
    }
%}

/* Se necesita para compatibilidad entre Sistemas Operativos */
// newline = (\r|\n|\r\n)

identificador = [a-zA-Z_]\w*
/* Tipos tambien pueden ser arrays con un tamano que puede ser definido */
type = (u?(byte|short|int|long)|string|char|float|bool/*|bit*/)(\[\d*\])?
/* Algunos opeadores aritmeticos y de comparacion se pueden usar en strings */

aritmeticOp = [\+\-\*%]|(\+\+|\-\-)|(\/[^\/]) // Daniel :(\/[^\/]) esta parte me parece extraña a pesar de intentar
                                               // descartar commentarios, me parese que esa comprobación cae en la
                                               // parte sintactica y no lexica
bitOp = [&\|\^~]|(>>|<<)
BooleanOp = \!|&&|\|\|
comparationOp = ([<>]=?)|(\!?=)
asignationOp = <-
string = \"([^\"\r\n\\]|(\\[\\\"net]))*\"
char =  '([^'\r\n\\]|\\[\\'net])'
int = (0b[01]+|0o[0-7]+|0x[0-9A-F]+)|\d+
float = \d*\.\d+(e[+-]?\d+)?
comment = \/\/.*
separator = [,\{\}\(\)\[\]:]
keyword = if|else|while|for|return|true|false|switch|fallthrough|case|default|continue|break|cast

%% // fin de options and declarations, inicio de lexical rules
<YYINITIAL> {//Estado inicial en el que se produce el análisis, cualquier token dentro de este estado es aceptado
    {keyword}               { return symbol(getSymIndex(yytext().toUpperCase())); }
    {type}                  { return symbol(getSymIndex(yytext().toUpperCase())); }
    "+"                     { return symbol(GrikeSym.PLUS); }
    "-"                     { return symbol(GrikeSym.MINUS); }
    "*"                     { return symbol(GrikeSym.TIMES); }
    "/"                     { return symbol(GrikeSym.DIVIDE); }
    "%"                     { return symbol(GrikeSym.MOD); }
    "++"                    { return symbol(GrikeSym.INC); }
    "--"                    { return symbol(GrikeSym.DEC); }
    //TODO:Listar por separado todos los operadores y separadores 
    \s+                     { /* Do nothing */ }
}

/*
{comentario}            {printyytext(" - comentario");}
{opAritmetico}          {printyytext(" - operador aritmético");}
{opBits}                {printyytext(" - operador de bits");}
{opBooleano}            {printyytext(" - operador booleano");}
{opComparacion}         {printyytext(" - operador comparación");}
{opAsignacion}          {printyytext(" - operador asignación");}
{char}                  {printyytext(" - char");}
{string}                {printyytext(" - string");}
{entero}                {printyytext(" - entero");}
{flotante}              {printyytext(" - flotante");}
{separador}             {printyytext(" - separador");}
{identificador}         {printyytext(" - identificador");}*/

[^]                     { throw new Error("LEXICAL ERROR: <" + yytext() + "> isn't a valid character"); }