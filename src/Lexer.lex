import java_cup.runtime.*; 
import sym;



%%    //*****************参数设置和声明段 (参数，词法状态，和宏定义)***********

%class Lexer  //将生成的类命名为Lexer
%line 
%column 
%cup     //使得与cup产生的处理器兼容
%unicode


//***宏定义***************
Letter = [a-zA-Z]
Digit = [0-9]

Comments
Identifier

Character
Boolean
Number
Integer
Rational
Float
Negative={-Number}








%%    //******************************************词法规则段*************
<YYINITIAL> {


//**Keywords*************
bool
int
rat
float
char

dict
seq

top
len

","
":"
"{"
"}"
";"
"("
")"
"."
"?"




//**Declaration***********
"tdef"{ return symbol(sym.TDEF); }    //type define
"alias"{ return symbol(sym.ALIAS); }  //别名


//**Expression************
"null"
"fdef"

//**Statements************
"read"
"print"
"if"
"then"
"fi"
"loop"
"pool"
"else"
"break"
"return"




//**Boolean***************
"!" { return symbol(sym.NOT); }
"&&"{ return symbol(sym.AND); }
"||"{ return symbol(sym.OR); }
"=>"{ return symbol(sym.IMPLICATION); }

//**Numeric***************
"+"{ return symbol(sym.PLUS); }
"-"{ return symbol(sym.MINUS); }
"*"{ return symbol(sym.MULTIPLE); }
"/"{ return symbol(sym.DIVIDE); }
"^"{ return symbol(sym.POWER); }

//**Dict operator
"in"{ return symbol(sym.IN); }
"::"{ return symbol(sym.CONCATENATION); }

//**Comparison
"<"{ return symbol(sym.LEFT_SHARP); }
"<="{ return symbol(sym.LEFT_SHARP_EQUAL); }
"="{ return symbol(sym.EQUAL); }
"!="{ return symbol(sym.NOT_EQUAL); }

//**Symbol****************
"["{ return symbol(sym.LEFT_SQUARE_BRACKET); }
"]"{ return symbol(sym.RIGHT_SQUARE_BRACKET); }












}