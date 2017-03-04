import java_cup.runtime.*;
import sym;

%%

%class CompilerLexer
%line
%column
%cup
%unicode

%{
StringBuffer strbuf = new StringBuffer(128);

private int len() { return yylength(); }
private String text() { return yytext(); }

private Symbol symbol(short id) {
    return new Symbol(id, yyline + 1, yycolumn + 1, len(), text());
}

private Symbol symbol(short id, String value) {
    return new Symbol(id, yyline + 1, yycolumn + 1, len(), value);
}
%}

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
NonZeroDigit = {1-9}
NegativeInteger = "-" {NonZeroDigit} {Digit}*
PositiveInteger = (0*) {NonZeroDigit} {Digit}*
Integer = {NegativeInteger} | {PositiveInteger} | 0
Fractional = ({Integer} | 0) "/" {Integer}
Rational = ({Integer} "_" {Fractional}) | {Integer} | {Fractional}
Float = {Integer} "." {Digit}+


%%
