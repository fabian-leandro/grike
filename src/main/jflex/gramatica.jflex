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
    int numEspacios = 0;

    static final char ESC = (char)27;
    static final String TEXT_DEFAULT = ESC + "[m";
    static final String TEXT_YELLOW = ESC + "[33m";

    /* Imprime yytext() de color amarillo seguido de un espacio y el mensaje */
    /* Nota: puede que no sea portable atravez de plataformas */
    void printyytext(String message) {
        System.out.println(TEXT_YELLOW + yytext() + TEXT_DEFAULT + ' ' + message);
    }
%}

/* Se necesita para compatibilidad entre Sistemas Operativos */
// newline = (\r|\n|\r\n)

/* guiones bajos? (snek_case) */
identificador = [a-zA-Z_]\w*
/* Tipos tambien pueden ser arrays con un tamano que puede ser definido */
tipo = (u?(byte|short|int|long)|string|char|float|bool)(\[\d*\])?
/* Algunos opeadores aritmeticos y de comparacion se pueden usar en strings */
opAritmetico = [\+\-\*%]|(\+\+|\-\-)|(\/[^\/])
opBits = [&\|\^~]|(>>|<<)
opBooleano = \!|&&|\|\|
opComparacion = ([<>]=?)|(\!?=)
opAsignacion = <-
//operador = {opAritmetico}|{opBits}|{opBooleano}|{opComparacion}|{opAsignacion}
string = \"([^\"\n]|(\\(\"|n|\\|e)))*\"
/* Notacion cientifica? (1.23e-9) */
/* Hexadecimal/Octal/Binario? (0xDEADBEEF/0777/111000b) */
numero = (\+|\-)?\d+(\.\d*)?
comentario = "//".*
/* ,{}():[]*/
separador = [,\{\}\(\)\[\]:]
palabraReservada = if|else|while|for|return|true|false|switch|fallthrough|case|default|continue|break|cast

%% // fin de options and declarations, inicio de lexical rules

/* Palabras reservadas deben ir antes de identificador para ser reconocidas */
{palabraReservada}      {printyytext("es palabraReservada");numPalabrasReservadas++;}
{tipo}                  {printyytext("es tipo");numTipos++;}
{comentario}            {printyytext("es comentario");numComentarios++;}
{opAritmetico}          {printyytext("es opAritmetico");numOpsAritmetico++;}
{opBits}                {printyytext("es opBits");numOpsBits++;}
{opBooleano}            {printyytext("es opBooleano");numOpsBooleano++;}
{opComparacion}         {printyytext("es opComparacion");numOpsComparacion++;}
{opAsignacion}          {printyytext("es opAsignacion");numOpsAsignacion++;}
//{operador}              {System.out.println(yytext()+" es operador");numOperadores++;}
{string}                {printyytext("es string");numStrings++;}
{numero}                {printyytext("es numero");numNumeros++;}
{separador}             {printyytext("es separador");numSeparadores++;}
{identificador}			{printyytext("es identificador");numIdentificadores++;}
\s+                     {printyytext("es un espacio");numEspacios++;}
[^]						{printyytext("es inválido");numInvalidos++;}











