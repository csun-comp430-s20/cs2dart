# cs2dart

A compiler that takes an arbitrary in-house subset of C#, named B ♭ (B Flat),
and creates new files written in an arbitrary in-house subset of Dart, named
Start.

## Usage

Download the Dart SDK (version => 2.7.1) simply run the main.dart file in the
bin folder.

For instance:

dart main.dart <path/to/file.cs>

## Features

Subtyping
Inheritance

## Grammar

KEYWORDS
keyword ::= ‘abstract’ | ‘as’ | ‘base’ | ‘bool’ | ‘break’ | ‘byte’ | ‘case’
            | ‘catch’ | ‘char’ | ‘checked’ | ‘class’ | ‘const’ | ‘continue’
            | ‘decimal’ | ‘default’ | ‘delegate’ | ‘do’ | ‘double’ | ‘else’
            | ‘enum’ | ‘event’ | ‘explicit’ | ‘extern’ | ‘false’ | ‘finally’
            | ‘fixed’ | ‘float’ | ‘for’ | ‘foreach’ | ‘goto’ | ‘if’ | ‘implicit’
            | ‘in’ | ‘int’ | ‘interface’ | internal’ | ‘is’ | ‘lock’ | ‘long’
            | ‘namespace’ | ‘new’ | ‘null’ | ‘object’ | ‘operator’ | ‘out’
            | ‘override’ | ‘params’ | ‘private’ | ‘protected’ | ‘public’
            | ‘readonly’ | ‘ref’ | ‘return’ | ‘sbyte’ | ‘sealed’ | ‘short’
            | ‘sizeof’ | ‘stackalloc’ | ‘static’ | ‘string’ | ‘struct’
            | ‘switch’ | ‘this’ | ‘throw’ | ‘true’ | ‘unsafe’ | ‘ushort’
            | ‘using’ | ‘virtual’ | ‘void’ | ‘volatile’ | ‘while’

IDENTIFIERS
identifier ::= Any string that is not a keyword or literal.

STATEMENTS
statement ::= declaration_statement
            | embedded_statement

declaration_statement ::= local_variable_declaration ‘;’
                        | local_const_declaration

local_variable_declaration ::= type identifier local_variable_initializer?

local_variable_declaration_initializer ::= ‘=’ expression

local_const_declaration ::=  ’const’ type identifier local_variable_initializer?

embedded_statement ::= block | empty_statement | expression_statement
                    | selection_statement | iteration_statement | jump_statement

block ::= ‘{‘ statement_list? ‘}’

statement_list ::= statement+

empty_statement ::= ’;’

expression_statement ::= statement_expression ‘;’ 

statement_expression ::= invocation_expression
                        | object_creation_expression
                        | assignment 

selection_statement ::= if_statement

if_statement ::= 'if' '(' boolean_expression ')' embedded_statement
                | 'if' '(' boolean_expression ')' embedded_statement 'else' embedded_statement 

boolean_expression ::= expression

iteration_statement ::= while_statement
                        | for_statment

while_statement ::= ’while’ ‘(‘ boolean_expression ‘)’ embedded_statement

for_statement ::= ’for’ ‘(‘ local_variable_declaration ‘;’ boolean_expression ‘;’  statement_expression ‘)’ embedded_statement

jump_statement ::= ‘return’ expression? ‘;’

EXPRESSIONS
expression ::= primary_expression | assignment_expression | additive_expression
            | multiplicative_expression | equality_expression | relational_expression
            | conditional_and_expression | conditional_or_expression 

primary_expression ::= literal | simple_name | parenthesized_expression | member_access
                    | invocation_expression | this_access | object_creation_expression
                    | typeof_expression | unary 

simple_Name ::= identifier

parenthesized_expression ::= ’(‘ expression ‘)’

member_access ::= type ‘.’ identifier | this_access ‘.’ identifier | simple_name ‘.’ identifier ;

Invocation_expression ::= primary_expression '(' argument_list? ')'

argument_list ::= expression (‘,’ expression)*

this_access ::= 'this'

object_creation_expression ::= 'new' type '(' argument_list? ')' 
 
typeof_expression ::= 'typeof' '(' type ')' | typeof' '(' identifier ')'

unary ::= ’false’ | ’true’

assignment_expression ::= primary_expression assignment_operator expression

assignment_operator ::= ‘=’ | ‘+=’ | ‘*=’ | ‘/=’ | ’%=’ ; 

additive_expression ::= primary_expression ‘+’ primary_expression
                    | primary_expression ‘-’ primary_express

mutliplicative_expression ::= primary_expression ‘*’ primary_expression
                            | primary_expression ‘/’ primary_expression
                            | primary_expression ‘%’ primary_expression

equality_expression ::= primary_expression ‘==’ primary_expression
                        | primary_expression ‘!=’ primary_expression

relational_expression ::= primary_expression ‘<’ primary_expression
                        | primary_expression ‘>’ primary_expression
                        | primary_expression ‘<=’ primary_expression
                        | primary_expression ‘>=’ primary_expression
                        | primary_expression ‘is’ primary_expression

conditional_and_expression ::= primary_expression ‘&&’ primary_expression

conditional_or_expression ::= primary_expression ‘||’ primary_expression

CLASSES
class_declaration ::= ‘class’ identifier class_Base? class_Body ‘;’?

class_base ::= ‘:’ identifier

class_body ::= ‘{‘ (constant_declaration | local_variable_declaration | method_declaration | constructor_declaration)* ‘}’

NAMESPACE
namespace ::= class_declaration

## Features and bugs

Please file feature requests and bugs at the
[issue tracker](https://github.com/csun-comp430-s20/cs2dart/issues).

## Copyright and licenses

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
