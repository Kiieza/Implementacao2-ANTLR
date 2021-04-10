gramática Calculadora;
INT    : [0-9]+;
DOUBLE : [0-9]+'.'[0-9]+;
PI     : 'pi';
E      : 'e';
POW    : '^';
NL     : '\n';
WS     : [ \t\r]+ -> pular;
ID     : [a-zA-Z_][a-zA-Z_0-9]*;

MAIS  : '+';
IGUAL : '=';
MENOS : '-';
MULT  : '*';
DIV   : '/';
LPAR  : '(';
RPAR  : ')';

input
    : setVar NL input     # ToSetVar
    | maisOuMenos NL? EOF # Calcule
    ;

setVar
    : ID IGUAL maisOuMenos # SetVariable
    ;


plusOrMinus 
    : maisOuMenos PLUS multOrDiv  # Plus
    | maisOuMenos MINUS multOrDiv # Minus
    | multOrDiv                   # ToMultOrDiv
    ;

multOrDiv
    : multOrDiv MULT pow # Multiplication
    | multOrDiv DIV pow  # Division
    | pow                # ToPow
    ;

pow
    : unaryMinus (POW pow)? # Power
    ;

unaryMinus
    : MINUS unaryMinus # ChangeSign
    | atom             # ToAtom
    ;

atom
    : PI                    # ConstantPI
    | E                     # ConstantE
    | DOUBLE                # Double
    | INT                   # Int
    | ID                    # Variable
    | LPAR plusOrMinus RPAR # Braces
    ;