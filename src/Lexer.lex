import java_cup.runtime.*; 
import sym;

%%    //参数设置和声明段 (参数，词法状态，和宏定义)
%class Lexer  //将生成的类命名为Lexer
%line 
%column 
%cup     //使得与cup产生的处理器兼容
%unicode




%%    //词法规则段