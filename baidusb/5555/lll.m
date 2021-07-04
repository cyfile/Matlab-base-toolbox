% 正则表达式\S匹配项
% \S  Any nonwhitespace character; equivalent to [^ \f\n\r\t\v]
regexp('\n',sprintf('\n'))
regexp(sprintf('\n'),'\n')
regexp('\n','\n')
regexp('\n','\S')
regexp(sprintf('\n'),'\S')
regexp(sprintf('\S'),'\n')
double('\n')
double(sprintf('\n'))
double('\S')
double(sprintf('\S'))

 

'\f\n\r\t\v'                                                          % 1×10 char

sprintf('\f\n\r\t\v')                                             % 1×5   char

double(sprintf('\f\n\r\t\v'))                               % 1×5   double

char(double(sprintf('\f\n\r\t\v')))                     % 1×5   char

isequal(char(double(sprintf('\f\n\r\t\v'))),sprintf('\f\n\r\t\v'))