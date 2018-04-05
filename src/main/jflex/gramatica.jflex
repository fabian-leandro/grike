// inicio user code

// incluir el paquete
package cr.ac.ucr.ci1322.kaguro;

%% // fin de user code, inicio de options and declarations

%public
%class GramaticaKaguro
%standalone

%unicode

%{
    static final char ESC = (char)27;
       static final String TEXT_DEFAULT = ESC + "[m";
       static final String TEXT_YELLOW = ESC + "[33m";
       static final String TEXT_GREEN = ESC + "[32m";
       static final String TEXT_RED = ESC + "[31m";

       /* Imprime yytext() de color amarillo seguido de un espacio y el mensaje */
       /* Nota: puede que no sea portable atravez de plataformas */
       void printyytext(String message) {
           String text = yytext().replaceAll("\n", "");
           System.out.println(TEXT_GREEN + text + TEXT_DEFAULT + ' ' + message);
       }

       /* Deberia ser mejor usar enums o enteros constantes */
       void printyytext(String message, String color) {
           String text = yytext().replaceAll("\n", "");
           System.out.println(color + text + TEXT_DEFAULT + ' ' + message);
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
string = \"([^\"\n]|(\\(\"|n|\\|e)))*\"
char =  '([^'\\]|\\['ne\\])'
entero = (0b[01]+|0o[0-7]+|0x[0-9A-F]+)|\d+
flotante = \d*\.\d+(e-?\d+)?
comentario = \/\/.*
separador = [,\{\}\(\)\[\]:]
palabraReservada = if|else|while|for|return|true|false|switch|fallthrough|case|default|continue|break|cast /*|struct|union|typedef|const*/

%% // fin de options and declarations, inicio de lexical rules

/* Palabras reservadas deben ir antes de identificador para ser reconocidas */
{palabraReservada}      {printyytext(" - palabra reservada");}
{tipo}                  {printyytext(" - tipo");}
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
{identificador}		    {printyytext(" - identificador");}
\s+                     {}
[^]						{printyytext("es inválido",TEXT_RED);}