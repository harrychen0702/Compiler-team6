
import java_cup.runtime.*;



%%

%class Lexer
%unicode
%cup
%line
%column

%eofval{
return symbol(sym.EOF);
%eofval}

%{

   StringBuffer string = new StringBuffer();
   private Symbol symbol(int type) {
   return new Symbol(type, yyline, yycolumn);
   //type, yyline, yycolumn
}
 private Symbol symbol(int type, Object value)
   {
    return new Symbol(type, yyline, yycolumn, value);
    //type, yyline, yycolum, value
   }

%}


Letter = [a-zA-Z]
Digit = [0-9]

// Comments
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/#" [^#] ~"#/" | "/#" "#"+ "/"
EndOfLineComment = "#" {InputCharacter}* {LineTerminator}

/*z language comments*/

// Whitespaces
Whitespace = "\t"|\r|\n|\r\n|" "


// Identifier
Identifier = {Letter} ({Letter} | _ | {Digit})*

// Data Literal
Character = "'" . "'"
Boolean = "T" | "F"
String = "\""  ~ "\""

// Numbers
NonzeroDigit = [1-9]
PositiveInteger = (0*) {NonzeroDigit} {Digit}*
Fractional = ({PositiveInteger} | 0) "/" {PositiveInteger}
Integer = ({PositiveInteger} | 0)
Rational = (Integer "_" {Fractional}) | {Integer} | {Fractional}
Float = {Integer} "." {Digit}+


%%

<YYINITIAL> {

{Comment}			{}
{Whitespace}		{}

// Comparison
"<="				{ return symbol(sym.LESSEQ); }
"=="				{ return symbol(sym.EQEQ); }
"!="				{ return symbol(sym.NOTEQ); }

// Boolean
"!"					{ return symbol(sym.NOT); }
"&&"				{ return symbol(sym.AND); }
"||"				{ return symbol(sym.OR); }

// Numeric Syntax
"+" 				{ return symbol(sym.PLUS); }
"-"					{ return symbol(sym.MINUS); }
"*"					{ return symbol(sym.MULT); }
"/"					{ return symbol(sym.DIV); }
"^"					{ return symbol(sym.POW); }

// Keywords

"char" 				{ return symbol(sym.CHAR); }
"int" 				{ return symbol(sym.INT); }
"rat" 				{ return symbol(sym.RAT); }
"float" 			{ return symbol(sym.FLOAT); }
"dict" 				{ return symbol(sym.DICT); }
"seq" 				{ return symbol(sym.SEQ); }
"top"				{ return symbol(sym.TOP); }
"string"			{ return symbol(sym.STRING); }

"tdef"				{ return symbol(sym.TDEF); }
"fdef"				{ return symbol(sym.FDEF); }
"alias"				{ return symbol(sym.ALIAS); }
"void"				{ return symbol(sym.VOID); }
"main"				{ return symbol(sym.MAIN); }
"return"			{ return symbol(sym.RETURN); }

"read"				{ return symbol(sym.READ); }
"print"				{ return symbol(sym.PRINT); }

"while"				{ return symbol(sym.WHILE); }
"forall"			{ return symbol(sym.FORALL); }
"if"				{ return symbol(sym.IF); }
"then"				{ return symbol(sym.THEN); }
"else"				{ return symbol(sym.ELSE); }
"elif"				{ return symbol(sym.ELIF); }
"fi"				{ return symbol(sym.ENDIF); }
"do"				{ return symbol(sym.DO); }
"od"				{ return symbol(sym.ENDDO); }



// Dictionary Syntax
"in"				{ return symbol(sym.IN); }
"::"				{ return symbol(sym.CONCAT); }

// Brackets
"<"					{ return symbol(sym.L_ANGLE); }
">"					{ return symbol(sym.R_ANGLE); }
"("					{ return symbol(sym.L_ROUND); }
")"					{ return symbol(sym.R_ROUND); }
"["					{ return symbol(sym.L_SQUARE); }
"]"					{ return symbol(sym.R_SQUARE); }
"{"					{ return symbol(sym.L_CURLY); }
"}"					{ return symbol(sym.R_CURLY); }

// Expression Symbol
":"					{ return symbol(sym.COLON); }
"="					{ return symbol(sym.EQ); }
","					{ return symbol(sym.COMMA); }
"."					{ return symbol(sym.DOT); }
";"					{ return symbol(sym.SEMICOLON); }

// Literals
{Character}			{ return symbol(sym.CHAR_LITERAL); }
{Float} 			{ return symbol(sym.FLOAT_LITERAL); }
{Integer}			{ return symbol(sym.INT_LITERAL); }
{Rational}			{ return symbol(sym.RAT_LITERAL); }
{String}			{ return symbol(sym.STRING_LITERAL); }
{Boolean}			{ return symbol(sym.BOOL_LITERAL); }
{Identifier}		{ return symbol(sym.IDENTIFIER); }

}

[^]         { throw new Error("Line " + yyline+1 + ", Column " + yycolumn); }
