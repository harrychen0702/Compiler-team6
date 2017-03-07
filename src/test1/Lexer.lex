import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  private boolean debug_mode;
  public  boolean debug()            { return debug_mode; }
  public  void    debug(boolean mode){ debug_mode = mode; }

//  Function print_lexeme
  private void print_lexeme(int type, Object value){
    if(!debug()){ return; }

    System.out.print("<");
    switch(type){
      case sym.LET:
        System.out.print("LET"); break;
      case sym.EQUAL:
        System.out.print(":="); break;
      case sym.SEMICOL:
        System.out.print(";"); break;
      case sym.PLUS:
        System.out.print("+"); break;
      case sym.MINUS:
        System.out.print("-"); break;
      case sym.MULT:
        System.out.print("*"); break;
      case sym.DIV:
        System.out.print("/"); break;
      case sym.LPAREN:
        System.out.print("("); break;
      case sym.RPAREN:
        System.out.print(")"); break;
      case sym.INTEGER:
        System.out.printf("INT %d", value); break;
      case sym.IDENTIFIER:
        System.out.printf("IDENT %s", value); break;
      case sym.MAIN:
        System.out.print("main"); break;
      case sym.LBRA:
            System.out.print("{"); break;
      case sym.RBRA:
            System.out.print("}"); break;
      case sym.PRINT:
            System.out.print("print"); break;
      case sym.CHAR:
            System.out.printf("CHAR %c", value); break;


    }
    System.out.print(">  ");
  }

  private Symbol symbol(int type) {
    print_lexeme(type, null);
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    print_lexeme(type, value);
    return new Symbol(type, yyline, yycolumn, value);
  }

%}

LineTerminator = \r|\n|\r\n
Whitespace = {LineTerminator}|" "|"\t"
InputCharacter = [^LineTerminator]

Letter = [a-zA-Z]
Digit = [0-9]
IdChar = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdChar}*
Integer = (0|[1-9]{Digit}*)

 /* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment   = "/#" [^#] ~"#/" | "/#" "#"+ "/"
EndOfLineComment     = "#" {InputCharacter}* {LineTerminator}?

/* character TODO: is \n a char?  */
character = [:jletterdigit:] | \p{Punctuation}| " "
char = "'"{character}"'"
string = "\"" {character}* "\""


//%state CHAR

%%

<YYINITIAL> {

 "T"           { return symbol(sym.TRUE);      }
 "F"           { return symbol(sym.FALSE);      }

//Keywords
  "main"        { return symbol(sym.MAIN); }
  "let"         { return symbol(sym.LET);        }
  "print"       { return symbol(sym.PRINT);     }
  "dict"        { return symbol(sym.DICT);}
  "len"         { return symbol(sym.LEN);}

// Types
  "bool"        { return symbol(sym.TYPE_BOOL);}
  "int"         { return symbol(sym.TYPE_INT);}
  "char"        { return symbol(sym.TYPE_CHAR);}
  "rat"         { return symbol(sym.TYPE_RAT);}
  "float"       { return symbol(sym.TYPE_FLOAT);}
  "top"         { return symbol(sym.TOP);}
  "seq"         { return symbol(sym.SEQ);}




// Other
  {Identifier}  { return symbol(sym.IDENTIFIER, yytext());   }
  {Integer}     { return symbol(sym.INTEGER,Integer.parseInt(yytext())); }

  {Whitespace}  { /* do nothing */               }
  ":"           { return symbol(sym.COLON);      }
  ":="          { return symbol(sym.EQUAL);      }
  ";"           { return symbol(sym.SEMICOL);    }
  ","           { return symbol(sym.COMMA);    }

  "+"           { return symbol(sym.PLUS);       }
  "-"           { return symbol(sym.MINUS);      }
  "*"           { return symbol(sym.MULT);       }
  "/"           { return symbol(sym.DIV);        }
  "("           { return symbol(sym.LPAREN);     }
  ")"           { return symbol(sym.RPAREN);     }
  "{"           { return symbol(sym.LBRA);       }
  "}"           { return symbol(sym.RBRA);       }
  "_"           { return symbol(sym.UNDERSCORE); }
  "."           { return symbol(sym.DOT);        }
  "<"           { return symbol(sym.LCROCHET);   }
  ">"           { return symbol(sym.RCROCHET);   }
  "["           { return symbol(sym.LAGRA);   }
  "]"           { return symbol(sym.RAGRA);   }





  {char}        { return symbol(sym.CHAR);       }
  {string}        { return symbol(sym.STRING);       }

//  \'            { string.setLength(0); yybegin(CHAR); }
}

//<CHAR> {
//  \'                             { yybegin(YYINITIAL);
//                                   return symbol(sym.CHAR,
//                                   string.toString()); }
//  {character}                    { string.append( yytext() ); }
//  [^]                            { throw new Error("Character must be closed with a '. Cant be void:" + yytext()); }
//}

[^]  {
  System.out.println("file:" + (yyline+1) +
    ":0: Error: Invalid input '" + yytext()+"'");
  return symbol(sym.BADCHAR);
}
