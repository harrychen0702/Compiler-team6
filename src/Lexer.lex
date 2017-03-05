import java_cup.runtime.*; 
import sym;



%%    //*****************参数设置和声明段 (参数，词法状态，和宏定义)***********

%class Lexer
//将生成的类命名为Lexer
%line 
%column 
%cup     //使得与cup产生的处理器兼容
%unicode

%{
      StringBuffer string = new StringBuffer();

      private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
      }
      private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
      }
%}

//***宏定义***************
Letter = [a-zA-Z]
Digit = [0-9]

Letter = [a-zA-Z]
Digit = [0-9]

LineTerminator = \n | \r | \r\n
InputCharacter = [^\r\n]

Whitespace = [ ] | \t | \f | {LineTerminator}

//Point 3
Comment = {FirstComment} | {SecondComment}
FirstComment = "#" {InputCharacter}* {LineTerminator}?
SecondComment = "/#" [^#] ~ "#/" | "/#" "#" +"/" | "/#" "#" + [^/#] ~ "#/"

//Point 4
Identifier = {Letter} ({Letter} | _ | {Digit})*

//Point 5
Character = '[^' \r\n\'\\ ']'

//Point 6
Boolean = 'T' | 'F'

//Point 7
NonZeroDigit = [1-9]
NegativeInteger = "-" {NonZeroDigit} {Digit}*
PositiveInteger = (0*) {NonZeroDigit} {Digit}*
Integer = {NegativeInteger} | {PositiveInteger} | 0
Fractional = ({Integer} | 0) "/" {Integer}
Rational = ({Integer} "_" {Fractional}) | {Integer} | {Fractional}
Float = {Integer} "." {Digit}+
//Comments
//Identifier
//
//Character
//Boolean
//Number
//Integer
//Rational
//Float
//Negative={-Number}


// xiaofengvery cool





%%    //******************************************词法规则段*************
<YYINITIAL> {


//**Keywords*************
bool {return symbol(sym.BOOL);}
int {return symbol(sym.INT);}
rat {return symbol(sym.RAT);}
float {return symbol(sym.FLOAT);}
char    {return symbol(sym.CHAR);}

dict {return symbol(sym.DICT);}
seq {return symbol(sym.SEQ);}

top {return symbol(sym.TOP);}
len {return symbol(sym.LEN);}

"," {return symbol(sym.COMMA);}
":" {return symbol(sym.COLON);}
"{" {return symbol(sym.LBRACE):}
"}" {return symbol(sym.RBRACE);}
";" {return symbol(sym.SEMICOLON);}
"(" {return symbol(sym.LPAREN);}
")" {return symbol(sym.RPAREN);}
"." {return symbol(sym.DOT);}
"?" {return symbol(sym.QUESTION);}




//**Declaration***********
//type define
"tdef" { return symbol(sym.TDEF); }
"fdef"	{ return symbol(sym.FDEF); }
 //别名
"alias" { return symbol(sym.ALIAS); }


//**Expression************
"null"  {return symbol(sym.NULL);}
"fdef"  {return symbol(sym.FDEF);}

//**Statements************
"read"  {return symbol(sym.READ);}
"print" {return symbol(sym.PRINT);}
"if"    {return symbol(sym.IF);}
"then"  {return symbol(sym.THEN);}
"fi"    {return symbol(sym.ENDIF);}
"loop"  {return symbol(sym.LOOP);}
"pool"  {return symbol(sym.POOL);}
"else"  {return symbol(sym.ELSE);}
"break" {return symbol(sym.BREAK);}
"return"    {return symbol(sym.RETURN);}




//**Boolean***************
"!" { return symbol(sym.NOT); }
"&&" { return symbol(sym.AND); }
"||" { return symbol(sym.OR); }
"=>" { return symbol(sym.IMPLICATION); }

//**Numeric***************
"+" { return symbol(sym.PLUS); }
"-" { return symbol(sym.MINUS); }
"*" { return symbol(sym.MULTIPLE); }
"/" { return symbol(sym.DIVIDE); }
"^" { return symbol(sym.POWER); }

//**Dict operator
"in" { return symbol(sym.IN); }
"::" { return symbol(sym.CONCATENATION); }

//**Comparison
"<" { return symbol(sym.LEFT_SHARP); }
"<=" { return symbol(sym.LEFT_SHARP_EQUAL); }
"=" { return symbol(sym.EQUAL); }
"!=" { return symbol(sym.NOT_EQUAL); }

//**Symbol****************
"[" { return symbol(sym.LEFT_SQUARE_BRACKET); }
"]" { return symbol(sym.RIGHT_SQUARE_BRACKET); }



}