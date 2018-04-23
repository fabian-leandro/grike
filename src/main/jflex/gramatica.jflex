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
%}

/* Se necesita para compatibilidad entre Sistemas Operativos */
// newline = (\r|\n|\r\n)

identificador = [a-zA-Z_]\w*
/* Tipos tambien pueden ser arrays con un tamano que puede ser definido */
tipo = (u?(byte|short|int|long)|string|char|float|bool/*|bit*/)(\[\d*\])?
/* Algunos opeadores aritmeticos y de comparacion se pueden usar en strings */
opAritmetico = [\+\-\*%]|(\+\+|\-\-)|(\/[^\/])
opBits = [&\|\^~]|(>>|<<)
opBooleano = \!|&&|\|\|
opComparacion = ([<>]=?)|(\!?=)
opAsignacion = <-
string = \"([^\"\r\n\\]|(\\[\\\"net]))*\"
char =  '([^'\r\n\\]|\\[\\'net])'
entero = (0b[01]+|0o[0-7]+|0x[0-9A-F]+)|\d+
flotante = \d*\.\d+(e[+-]?\d+)?
comentario = \/\/.*
separador = [,\{\}\(\)\[\]:]
palabraReservada = if|else|while|for|return|true|false|switch|fallthrough|case|default|continue|break|cast

%% // fin de options and declarations, inicio de lexical rules
{palabraReservada}      {return new Symbol(getSymIndex(yytext().toUpperCase()));}
{tipo}                  {return new Symbol(getSymIndex(yytext().toUpperCase()));}

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
{identificador}         {printyytext(" - identificador");}
\s+                     {}
[^]                     {printyytext(" - inválido");}