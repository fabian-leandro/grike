// inicio user code

// incluir el paquete
package cr.ac.ucr.ci1322.kaguro;

%% // fin de user code, inicio de options and declarations

%public
%class GramaticaKaguro
%standalone

%unicode

%{
    int numIdentificadores = 0;
    int numTipos = 0;
    int numOpsAritmetico = 0;
    int numOpsBits = 0;
    int numOpsBooleano = 0;
    int numOpsComparacion = 0;
    int numOpsAsignacion = 0;
    int numOperadores = 0;
    int numStrings = 0;
    int numNumeros = 0;
    int numPalabrasReservadas = 0;
    int numComentarios = 0;
    int numSeparadores = 0;
    int numInvalidos = 0;
%}

identificador = [a-zA-Z]\w*
tipo = (u?(byte|short|int|long)|string|char|float|bool)(\[\])?
opAritmetico = [\+\-\*\/%]|(\+\+|\-\-)
opBits = [&\|\^~]|(>>|<<)
/*opBooleano = (!|&&|\|\|)
opComparacion = ([<>]=?)|(!?=)
opAsignacion = (<-)|(*=|+=|-=|/=)
operador = {OP_ARITMETICO}|{OP_BITS}|{OP_BOOLEANO}|{OP_COMPARACION}|{OP_ASIGNACION}
string = "([^"\\\n]|(\\("|n|\\|e)))*"
numero = (+|-)?\d+(./d*)?
palabraReservada = if|else|while|for|return|true|false|switch|fallthrough|case|default
comentario = //[^/r/n]*\n
separador = [,\{\}\(\)]*/

%% // fin de options and declarations, inicio de lexical rules

{identificador}			{System.out.println(yytext()+" es identificador");numIdentificadores++;}
{tipo}                  {System.out.println(yytext()+" es tipo");numTipos++;}
{opAritmetico}          {System.out.println(yytext()+" es opAritmetico");numOpsAritmetico++;}
{opBits}                {System.out.println(yytext()+" es opBits");numOpsBits++;}
/*{opBooleano}            {System.out.println(yytext()+" es opBooleano");numOpsBooleano++;}
{opComparacion}         {System.out.println(yytext()+" es opComparacion");numOpsComparacion++;}
{opAsignacion}          {System.out.println(yytext()+" es opAsignacion");numOpsAsignacion++;}
{operador}              {System.out.println(yytext()+" es operador");numOperadores++;}
{string}                {System.out.println(yytext()+" es string");numStrings++;}
{numero}                {System.out.println(yytext()+" es numero");numNumeros++;}
{palabraReservada}      {System.out.println(yytext()+" es palabraReservada");numPalabrasReservadas++;}
{comentario}            {System.out.println(yytext()+" es comentario");numComentarios++;}
{separador}             {System.out.println(yytext()+" es separador");numSeparadores++;}*/
[^]						{System.out.println(yytext()+" es inválido");numInvalidos++;}











