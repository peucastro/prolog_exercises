/* a) Implement print_n(+N, +S) which prints symbol S to the terminal N times. */

print_n(0, _) :- !.
print_n(N, S) :- N > 0,
                 put_char(S),
                 N1 is N - 1,
                 print_n(N1, S).

/*
b) Implement print_text(+Text, +Symbol, +Padding) which prints the text received in the first argument (using double quotes) with the padding received in the third argument (number of spaces before and after the text), and surrounded by Symbol.

Example:
| ?- print_text("Hello!", '*', 4).
*    Hello!    *
*/

print_string([]).
print_string([Char | Suffix]) :- put_code(Char),
                                print_string(Suffix).

print_text(Text, Symbol, Padding) :- Padding >= 0,
                                     put_char(Symbol),
                                     print_n(Padding, ' '),
                                     print_string(Text),
                                     print_n(Padding, ' '),
                                     put_char(Symbol).

/*
c) Implement print_banner(+Text, +Symbol, +Padding) which prints the text received in the first argument (using double quotes) using the format of the example below:
| ?- print_banner("Hello World!", '*', 4).
**********************
*                    *
*    Hello World!    *
*                    *
**********************
*/

print_banner([], _, _) :- !.
print_banner(Text, Symbol, Padding) :- length(Text, TextLength),
                                       TextLength > 0,
                                       RowLength is 2 + 2 * Padding + TextLength,
                                       SeparatorLength is RowLength - 2,
                                       print_n(RowLength, Symbol), nl,
                                       put_char(Symbol), print_n(SeparatorLength, ' '), put_char(Symbol), nl,
                                       put_char(Symbol), print_n(Padding, ' '), print_string(Text), print_n(Padding, ' '), put_char(Symbol), nl,
                                       put_char(Symbol), print_n(SeparatorLength, ' '), put_char(Symbol), nl,
                                       print_n(RowLength, Symbol), nl.

/*
d) Implement read_number(-X), which reads a number from the standard input, digit by digit (i.e., without using read), returning that number (as an integer).
Suggestion: use peek_code to determine when to terminate the reading cycle (the ASCCI code for Line Feed is 10).
*/

read_number_aux(Acc, Acc) :- peek_code(10),
                             get_code(_), !.
read_number_aux(Acc, X) :- peek_code(Code),
                           Code \= 10,
                           get_code(DigitCode),
                           Digit is DigitCode - 48,
                           NewAcc is Acc * 10 + Digit,
                           read_number_aux(NewAcc, X).

read_number(X) :- read_number_aux(0, X).

/*
e) Implement read_until_between(+Min, +Max, -Value), which asks the user to insert an integer number between Min and Max, and succeeds only when the value inserted is within those limits.
Hint: ensure that the read_number/1 predicate is determinate.
*/

:- use_module(library(between)).

read_until_between(Min, Max, Value) :- repeat,
                                       read_number(Value),
                                       between(Min, Max, Value), !.

/*
f) Implement read_string(-X), which reads a string of characters from the standard input, character by character, returning a string (i.e., a list of ASCII codes).
*/

check_and_read(10, []) :- !.
check_and_read(Code, [Code | Rest]) :- get_code(NextCode),
                                       check_and_read(NextCode, Rest).

read_string(String) :- get_code(Code),
                       check_and_read(Code, String).

/* g) Implement banner/0, which asks the user for the arguments to use in a call to print_banner/3, reads those arguments, and invokes the predicate. */

banner :- write('Text: '),
          read_string(Text),
          write('Symbol: '),
          get_char(Symbol),
          write('Padding: '),
          skip_line,
          read_number(Padding),
          print_banner(Text, Symbol, Padding).
