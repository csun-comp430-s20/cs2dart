import 'package:cs2dart/parser.dart';
import 'package:cs2dart/src/classes/classAST.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/expressions/primary_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/additive_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/assignment_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/conditional_and_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/conditional_or_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/equality_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/invocation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/literal.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/member_access.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/multiplicative_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/object_creation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/parenthesized_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/relational_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/simple_name.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/this_access.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/typeof_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/unary.dart';
import 'package:cs2dart/src/expressions/variants/primary_no_array_creation_expression.dart';
import 'package:cs2dart/src/types/variants/reference_type.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/expressions.dart';
import '../classes/variants/variants/variants/FixedParam.dart';
import 'dart:io';

import '../namespaces/namespace.dart';
import '../namespaces/namespace.dart';
import '../parser/parser_ast2.dart';
import '../../parser.dart';
import '../interfaces/interface.dart';
import '../interfaces/variants/InterfaceBase.dart';
import '../interfaces/variants/InterfaceBody.dart';
import '../interfaces/variants/InterfaceDeclaration.dart';
import '../interfaces/variants/InterfaceModifier.dart';
import '../../statement.dart';
import '../classes/classAST.dart';
import '../classes/variants/ClassBody.dart';
//import '../classes/variants/variants/ConstantDeclaration.dart';
import '../classes/variants/variants/ConstructorDeclaration.dart';
import '../classes/variants/variants/FieldDeclaration.dart';
import '../classes/variants/variants/MethodDeclaration.dart';
import '../classes/variants/ClassDeclaration.dart';
import '../classes/variants/ClassBase.dart';
import '../classes/variants/ClassModifier.dart';
import '../statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import '../statements/variants/EmbeddedStatementVariants/expression_statement.dart';
import '../statements/variants/DeclarationStatementVariants/LocalVariableDeclarationVariants/LocalVariableDeclaratorsVariants/LocalVariableDeclaratorVariants/local_variable_initializer.dart';
import '../tokens/variants/identifier_token.dart';
import '../tokens/variants/identifier_token.dart';
import '../tokens/variants/identifier_token.dart';
import '../types/type.dart';
import '../types/variants/reference_type.dart';
import '../types/variants/value_type.dart';
import '../types/variants/variants/floating_point_type.dart';
import '../types/variants/variants/integral_type.dart';
import '../tokens/variants/identifier_token.dart';
import '../tokens/variants/integer_literal_token.dart';
import '../tokens/variants/keyword_token.dart';
import '../tokens/variants/operator_or_punctuator_token.dart';

class Parser {
  Parser(this._tokens);

  final List<Token> _tokens;
  int _position = 0;

  // We don't use this method
  void checkTokenIs(int position, Token input) {
    // equals written, need to test, unsure why error
    if (!_tokens[position].equals(input)) {
      throw ParseException('Expected: ' +
          input.toString() +
          'Received: ' +
          _tokens[position].toString());
    }
  }

  //dump this into parser_assist later
  bool _isInterfaceModifier(KeywordToken input) {
    //modifie to check for repeats
    if (input.value == 'new' ||
        input.value == 'public' ||
        input.value == 'protected' ||
        input.value == 'internal' ||
        input.value == 'private') {
      return true;
    } else {
      return false;
    }
  }

  bool _isType(KeywordToken input) {
    if (input.value == 'bool' ||
        input.value == 'byte' ||
        input.value == 'char' ||
        input.value == 'double' ||
        input.value == 'float' ||
        input.value == 'int' ||
        input.value == 'long' ||
        input.value == 'sbyte' ||
        input.value == 'short' ||
        input.value == 'string' ||
        input.value == 'uint' ||
        input.value == 'ulong' ||
        input.value == 'ushort') {
      return true;
    } else {
      return false;
    }
  }
  //end interface helper functions

  // parseClassBase Breakdown
  // 0 --> : Token
  // 1 --> Identifier Token
  // seems done
  ClassBase parseClassBase() {
    var startPos = _position;
    var output = ClassBase(new List());
    if (_tokens[_position] is OperatorOrPunctuatorToken &&
        _tokens[_position].value == ':') {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position] is IdentifierToken) {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      } else {
        _position = startPos;
        return null;
      }
    } else {
      _position = startPos;
      return null;
    }
  }

  // 0 --> Type Object
  // 1 --> Identifier Token
  FixedParam parseFixedParam() {
    //var startPos = _position;
    var output = FixedParam(new List());
    var type = parseType();
    if (type != null) {
      output.value.add(type);
      if (_tokens[_position] is IdentifierToken) {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> Type Object or Void Token
  // 1 --> Identifier
  // 2 --> ( Token
  // 3 to X --> FixedParam Object
  // X + 1 --> ) Token
  // X + 2 --> Block Statement Object
  MethodDeclaration parseMethodDeclaration() {
    var startPos = _position;
    var output = MethodDeclaration(new List());
    print(_tokens[_position].value);
    var returnType = parseType();
    if (returnType != null) {
      output.value.add(returnType);
    } else {
      if (_tokens[_position].value == 'void') {
        output.value.add(_tokens[_position]);
        _position++;
      } else {
        return null;
      }
    }
    if (_tokens[_position] is IdentifierToken) {

      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        var param;
        while (_tokens[_position].value != ')') {
          if (_position >= _tokens.length) {
            _position = startPos;
            return null;
          }
          param = parseFixedParam();
          if (param != null) {
            output.value.add(param);
          } else {
            _position = startPos;
            return null;
          }
        }
        output.value.add(_tokens[_position]);
        _position++;
        var block = parseBlockStatement();
        if (block != null) {
          output.value.add(block);
          return output;
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      _position = startPos;
      return null;
    }
  }

  // 0 --> Identifier Token
  // 1 --> ( Token
  // 2 --> Fixed Param Object
  // 3 --> ) Token
  // 4 --> Block Statement Object
  ConstructorDeclaration parseConstructorDeclaration() {
    var startPos = _position;
    var output = ConstructorDeclaration(new List());
    if (_tokens[_position] is IdentifierToken) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        var param;
        while (_tokens[_position].value != ')') {
          if (_position > _tokens.length) {
            _position = startPos;
            return null;
          }
          param = parseFixedParam();
          if (param != null) {
            output.value.add(param);
          } else {
            _position = startPos;
            return null;
          }
        }
        output.value.add(_tokens[_position]);
        _position++;
        var block = parseBlockStatement();
        if (block != null) {
          output.value.add(block);
          return output;
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  // parseClassBody Breakdown
  // 0 --> { Token
  // 2 to X --> (Below)
  //     constantDeclaration
  //     localVariableDeclaration
  //     methodDeclaration
  //     constructorDeclaration
  // X is '}'
  // done, need to finish helper methods
  ClassBody parseClassBody() {
    print("here246");
    var startPos = _position;
    var output = ClassBody(new List());
    if (_tokens[_position] is OperatorOrPunctuatorToken &&
        _tokens[_position].value == '{') {
      output.value.add(_tokens[_position]);
      _position++;
      while (_tokens[_position].value != '}') {
        print(_tokens[_position].value);
        //if end of list without braket return null
        if (_position >= _tokens.length) {
          _position = startPos;
          return null;
        }
        var constDecl = parseConstantDeclaration();

        if (constDecl != null) {
          output.value.add(constDecl);
          if(_tokens[_position].value == ';'){
            output.value.add(_tokens[_position]);
            _position++;

          }
          else{
            _position = startPos;
            return null;
          }
        }
        else {
          var fieldDecl = parseLocalVariableDeclaration();
          print(fieldDecl.runtimeType.toString());

          if (fieldDecl != null) {
            output.value.add(fieldDecl);
            if(_tokens[_position].value == ';'){
              output.value.add(_tokens[_position]);
              _position++;
            }
            else{
              output.value.removeLast();
              _position = _position -2;
             var methodDecl = parseMethodDeclaration();
             print(methodDecl.runtimeType.toString());
             if(methodDecl !=null){
               output.value.add(methodDecl);
             }
             else{
               var constructorDecl = parseConstructorDeclaration();
              if (constructorDecl != null) {
                output.value.add(constructorDecl);
              } else {
                _position = startPos;
                return null;
              }
             }
            }
          } else {
            var methodDecl = parseMethodDeclaration();
            if (methodDecl != null) {
              output.value.add(methodDecl);
            } else {
              var constructorDecl = parseConstructorDeclaration();
              if (constructorDecl != null) {
                output.value.add(constructorDecl);
              } else {
                _position = startPos;
                return null;
              }
            }
          }
        }
      }
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      _position = startPos;
      return null;
    }
  }

  // parseClass Breakdown
  // 0 --> class Keyword Token
  // 1 --> Identifier Token
  // 2 --> Class Base Object     or... 2 --> Class Body Object
  // 3 --> Class Body Object     or... 3 --> ; Token (optional)
  // 4 --> ; Token (optional)
  ClassDeclaration parseClass() {
    var startPos = _position;
    var output = ClassDeclaration(new List());
    if (_tokens[_position] is KeywordToken &&
        _tokens[_position].value == 'class') {
      output.value.add(_tokens[_position]);
      _position++;
      // identifier
      if (_tokens[_position] is IdentifierToken) {
        output.value.add(_tokens[_position]);
        _position++;

        // class base
        if (_tokens[_position] is OperatorOrPunctuatorToken &&
            _tokens[_position].value == ':') {
          var classBase = parseClassBase();
          if (classBase == null) {
            _position = startPos;
            return null;
          } else {
            output.value.add(classBase);
          }
        }
        //class body
        var body = parseClassBody();
        if (body != null) {
          output.value.add(body);
          if(_position < _tokens.length){
            if (_tokens[_position] is OperatorOrPunctuatorToken &&
                _tokens[_position].value == ';') {
              output.value.add(_tokens[_position]);
              _position++;
            }
          }
          return output;
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      _position = startPos;
      return null;
    }
  }

  // 0 --> PrimaryNoArrayCreationExpression Object
  LocalVariableInitializer parseLocalVariableInitializer() {
    var tmpExp = parseExpression();

    var output = LocalVariableInitializer(List());
    if (tmpExp != null) {
      output.value.add(tmpExp);
      return output;
    } else {
      return null;
    }
  }

  // 0 --> Identifier
  // 1 --> = Token
  // 2 --> Local Variable Initializer Object
  LocalVariableDeclarator parseLocalVariableDeclarator() {
    //print(_position);
    //print(_tokens.length);
    var startPos = _position;
    var output = LocalVariableDeclarator(List());
    if (_tokens[_position].type == TokenType.identifier) {
      output.value.add(_tokens[_position]);
      _position++;
      //print("here449");
      if (_tokens[_position].value == '=') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpLocVarInit = parseLocalVariableInitializer();
        if (tmpLocVarInit != null) {
          output.value.add(tmpLocVarInit);
          return output;
        } else {
          _position = startPos;
          return null;
        }
      } else {
        return output;
      }
    }
    _position = startPos;
    return null;
  }

  // 0 --> Type Object
  LocalVariableType parseLocalVariableType() {
    var startPos = _position;
    var output = LocalVariableType(List());
    var tmpType = parseType();
    if (tmpType != null) {
      output.value.add(tmpType);
      //_position++;
      return output;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Local Variable Type
  // 1 --> Local Variable Declarator Object
  LocalVariableDeclaration parseLocalVariableDeclaration() {
    var startPos = _position;
    var output = LocalVariableDeclaration(List());
    var newLocalVarType = parseLocalVariableType();
    if (newLocalVarType != null) {
      //print("here506");
      output.value.add(newLocalVarType);
      //_position++;

      var newLocalVarDec = parseLocalVariableDeclarator();

      if (newLocalVarDec != null) {
        //print("here513");
        output.value.add(newLocalVarDec);
        //_position++;
        //print(output.runtimeType.toString());
        return output;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> const Token
  // 1 --> identifier Token
  // 2 --> '=' Token
  // 3 --> Expression Object
  ConstantDeclaration parseConstantDeclaration() {
    var startPos = _position;
    var output = ConstantDeclaration(List());
    if(_tokens[_position].value == 'const'){
      //print("here533");
      output.value.add(_tokens[_position]);
      _position++;
      var type = parseType();
      if (type != null){
        output.value.add(type);
        if (_tokens[_position].type == TokenType.identifier) {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position].value == "=") {
          output.value.add(_tokens[_position]);
          _position++;
          var tmpExpr = parseExpression();
          if (tmpExpr != null) {
            output.value.add(tmpExpr);
            //_position++;
            return output;
          }
          _position = startPos;
          return null;
        }
        return output;
      }
      _position = startPos;
      return null;
      }
      else{
        _position = startPos;
        return null;
      }
    }
    else{
      return null;
    }
  }

  // (Optional 0 indexes)
  // 0 --> Local Variable Declaration Object
  // or...
  // 0 --> Constant Declaration Object
  // 1 --> ; Token
  DeclarationStatement parseDeclarationStatement() {
    var startPos = _position;
    var output = DeclarationStatement(List());
    var tmp = parseLocalVariableDeclaration();
    if (tmp != null && _tokens[_position].value == ';') {
      output.value.add(tmp);
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      var tmp = parseConstantDeclaration();
      if (tmp != null && _tokens[_position].value == ';') {
        output.value.add(tmp);
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      }
    }
    _position = startPos;
    return null;
  }

  // 0 --> { Token
  // 1 to X --> Statements Object
  // X + 1 --> } Token
  //Done
  Block parseBlockStatement() {
    var startPos = _position;
    var output = Block(new List());
    if (_tokens[_position].value == '{') {
      output.value.add(_tokens[_position]);
      _position++;
      var temp;
      while (_tokens[_position].value != '}') {
        if (_position > _tokens.length) {
          _position = startPos;
          return null;
        }
        temp = parseStatements();
        if (temp != null) {
          output.value.add(temp);
        } else {
          _position = startPos;
          return null;
        }
      }
      if (_tokens[_position].value == '}') {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> ; Token
  //Done
  EmptyStatement parseEmptyStatement() {
    if (_tokens[_position].value == ';') {
      var output = EmptyStatement(new List());
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      return null;
    }
  }

  // (Optional 0 indexes)
  // 0 --> Invocation Expression Object
  // or...
  // 0 --> Object Creation Expression Object
  // or...
  // 0 --> Assignment Expression Object
  // 1 --> ; Token
  ExpressionStatement parseExpressionStatement() {
    var startPos = _position;
    var output = ExpressionStatement(new List());
    var expression = parseInvocationExpression();
    if (expression == null) {
      ObjectCreationExpression expression = parseObjectCreationExpression();
      if (expression == null) {
        AssignmentExpression expression = parseAssignmentExpression();
        if (expression == null) {
          return null;
        }
      }
    }
    output.value.add(expression);
    if (_tokens[_position].value == ';') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      return null;
    }
  }

  // 0 --> for keyword Token
  // 1 --> ( Token
  // 2 --> Local Variable Declaration Object    or...   2 --> Expression Statement
  // 3 --> ; Token
  // 4 --> Expression Object
  // 5 --> ; Token
  // 6 --> Expression Statement Object
  // 7 --> ) Token
  // 8 --> Embedded Statement Object
  ForStatement parseForStatement() {
    var startPos = _position;
    var output = ForStatement(new List());
    if (_tokens[_position].value == 'for') {
      print("here732");
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position].value == '('){
        print('here736');
         output.value.add(_tokens[_position]);
         _position++;
         //IMPORTANT: using Statement here might be a bad idea, look here first for bugs in for loop
         Statement initializer = parseLocalVariableDeclaration();
         if(initializer == null){
           initializer = parseExpressionStatement();
         }
         if(initializer != null){
           output.value.add(initializer);
           if(_tokens[_position].value == ';'){
             output.value.add(_tokens[_position]);
             _position++;
             var condition = parseExpression();
             if(condition != null){
               print('here753');
               output.value.add(condition);
               if(_tokens[_position].value == ';'){
                 output.value.add(_tokens[_position]);
                 _position++;
                 var iterator = parseExpressionStatement();
                 if(iterator != null){
                   output.value.add(iterator);
                   if(_tokens[_position].value == ')'){
                     output.value.add(_tokens[_position]);
                     _position++;
                     var embedded = parseEmbeddedStatement();
                     if(embedded != null){
                       output.value.add(embedded);
                       return output;
                     }
                     else{
                       _position = startPos;
                       return null;
                     }
                   }
                   else{
                     _position = startPos;
                     return null;
                   }
                 }
                 else{
                   _position = startPos;
                   return null;
                 }
               }
               else{
                 _position = startPos;
                 return null;
               }
             }
             else{
               _position = startPos;
               return null;
             }
           }
           else{
            _position = startPos;
            return null;
          }
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> while keyword Token
  // 1 --> ( Token
  // 2 --> Expression Object
  // 3 --> ) Token
  // 4 --> Embedded Statement Object
  WhileStatement parseWhileStatement() {
    var startPos = _position;
    var output = WhileStatement(new List());
    if (_tokens[_position].value == 'while') {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        var boolean = parseExpression();
        if (boolean != null) {
          output.value.add(boolean);
          if (_tokens[_position].value == ')') {
            output.value.add(_tokens[_position]);
            _position++;
            var embeded = parseEmbeddedStatement();
            if (embeded != null) {
              output.value.add(embeded);
              return output;
            } else {
              _position = startPos;
              return null;
            }
          } else {
            _position = startPos;
            return null;
          }
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> For Statement Object
  // or...
  // 0 --> While Statement Object
  //finished when expression methods are created
  IterationStatement parseIterationStatement() {
    IterationStatement output = parseForStatement();
    if (output != null) {
      return output;
    } else {
      output = parseWhileStatement();
      if (output != null) {
        return output;
      } else {
        return null;
      }
    }
  }

  // 0 --> return keyword Token
  // 1 --> Expression Object
  // 2 --> ; Token
  JumpStatement parseJumpStatement() {
    var startPos = _position;
    var output = JumpStatement(new List());
    if (_tokens[_position].value == 'return') {
      output.value.add(_tokens[_position]);
      _position++;
      var expression = parseExpression();
      if (expression != null) {
        output.value.add(expression);
      }
      if (_tokens[_position].value == ';') {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> if keyword Token
  // 1 --> ( Token
  // 2 --> Expression Object
  // 3 --> ) Token
  // 4 --> Embedded Statement Object
  // 5 --> else keyword Token
  // 6 --> Embedded Statement Object
  SelectionStatement parseSelectionStatement() {
    var startPos = _position;
    var output = SelectionStatement(new List());
    if (_tokens[_position].value == 'if') {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        var boolean = parseExpression();
        if (boolean != null) {
          output.value.add(boolean);
          if (_tokens[_position].value == ')') {
            output.value.add(_tokens[_position]);
            _position++;
            var embeded = parseEmbeddedStatement();
            if (embeded != null) {
              output.value.add(embeded);
              if (_tokens[_position].value == 'else') {
                output.value.add(_tokens[_position]);
                _position++;
                var embeded2 = parseEmbeddedStatement();
                if (embeded2 != null) {
                  output.value.add(embeded2);
                  return output;
                } else {
                  _position = startPos;
                  return null;
                }
              } else {
                return output;
              }
            } else {
              _position = startPos;
              return null;
            }
          } else {
            _position = startPos;
            return null;
          }
        } else {
          _position = startPos;
          return null;
        }
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  // 0 --> Block Statement Object
  // or...
  // 0 --> Empty Statement Object
  // or...
  // 0 --> Expression Statement Object
  // or...
  // 0 --> Iteration Statement Object
  // or...
  // 0 --> Jump Statement Object
  // or...
  // 0 --> Selection Statement Object
  EmbeddedStatement parseEmbeddedStatement() {
    //var startPos = _position;
    //IMPORTANT: When doing typecheck, make sure doing inheritance like this doesnt screw up type
    EmbeddedStatement output = parseBlockStatement();
    if (output != null) {
      return output;
    } else {
      output = parseEmptyStatement();
      if (output != null) {
        return output;
      } else {
        output = parseExpressionStatement();
        if (output != null) {
          return output;
        } else {
          output = parseIterationStatement();
          if (output != null) {
            return output;
          } else {
            output = parseJumpStatement();
            if (output != null) {
              return output;
            } else {
              output = parseSelectionStatement();
              if (output != null) {
                return output;
              } else {
                return null;
              }
            }
          }
        }
      }
    }
  }

  // 0 --> Declaration Statement Object
  // or...
  // 0 --> Embedded Statement Object
  Statement parseStatements() {
    Statement output;
    output = parseDeclarationStatement();
    if (output != null) {
      return output;
    } else {
      output = parseEmbeddedStatement();
      return output;
    }
  }

  // 0 --> sbyte keyword Token
  // or...
  // 0 --> byte keyword Token
  // or...
  // 0 --> (THE REST OF THE TYPES BELOW) Token
  IntegralType parseIntegralType() {
    var output = IntegralType(new List());
    if (_tokens[_position].value == 'sbyte' ||
        _tokens[_position].value == 'byte' ||
        _tokens[_position].value == 'short' ||
        _tokens[_position].value == 'ushort' ||
        _tokens[_position].value == 'int' ||
        _tokens[_position].value == 'uint' ||
        _tokens[_position].value == 'long' ||
        _tokens[_position].value == 'ulong' ||
        _tokens[_position].value == 'char') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      return null;
    }
  }

  // 0 --> float keyword Token
  // or...
  // 0 --> double keyword Token
  FloatingPointType parseFloatingPointType() {
    var output = FloatingPointType(new List());
    if (_tokens[_position].value == 'float' ||
        _tokens[_position].value == 'double') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      return null;
    }
  }

  // 0 --> bool keyword Token
  // or...
  // 0 --> decimal keyword Token
  // or...
  // 0 --> Integral Type Object
  // or...
  // 0 --> Floating Point Type Object
  ValueType parseValueType() {
    //var startPos = _position;
    var output = ValueType(new List());
    if (_tokens[_position].value == 'bool') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      if (_tokens[_position].value == 'decimal') {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      } else {
        var integralType = parseIntegralType();
        if (integralType != null) {
          output.value.add(integralType);
          return output;
        } else {
          var floatingType = parseFloatingPointType();
          if (floatingType != null) {
            output.value.add(floatingType);
            return output;
          } else {
            return null;
          }
        }
      }
    }
  }

  // 0 --> object keyword Token
  // or...
  // 0 --> string keyword Token
  // or...
  // 0 --> identifier Token
  ReferenceType parseReferenceType() {
    var output = ReferenceType(new List());
    if (_tokens[_position].value == 'object') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else if (_tokens[_position].value == 'string') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    //maybe change handling of custom types
    else if (_tokens[_position] is IdentifierToken) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      return null;
    }
  }

  // 0 --> Value Type Object
  // or...
  // 0 --> Reference Type Object
  Type parseType() {
    //var startPos = _position;
    var output;
    output = parseValueType();
    if (output != null) {
      return output;
    } else {
      output = parseReferenceType();
      if (output != null) {
        return output;
      } else {
        return null;
      }
    }
  }

  // 0 --> Literal Expression object
  // or...
  // 0 --> parenthized Expression object
  // or...
  // 0 --> member access expression object
  // or...
  // 0 --> invocation expression object
  // or...
  // 0 --> this access expression object
  // or...
  // 0 --> object creation expression object
  // or...
  // 0 --> type of expression object
  // Need to fix up
  PrimaryExpression parsePrimaryExpression(){
    PrimaryExpression output;
    output = parseTypeOfExpression();
    if(output != null){
      return output;
    }
    else{
      output = parseParenthizedExpression();
      if(output!=null){
        return output;
      }
      else{
        output = parseMemberAccessExpression();
        if (output != null){
          return output;
        }
        else{
          output = parseInvocationExpression();
          if (output != null){
            return output;
          }
          else{
            output = parseThisAccessExpression();
            if(output != null){
              return output;
            }
            else{
              output = parseObjectCreationExpression();
              if(output != null){
                return output;
              }
              else{
                output = parseLiteralExpression();
                
                if(output != null){
                  return output;
                }
                else{
                   output = parseSimpleName();
                    if(output != null){
                      return output;
                    }
                    else{
                      output = parseUnary();
                      if(output != null){
                        return output;
                      }
                    }
                }
              }
            }
          }
        }
      }
    }
  }

  // 0 --> this
  ThisAccess parseThisAccessExpression(){
    var output = ThisAccess(List());
    var startPos = _position;

    if (_tokens[_position].value == 'this') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    else{
      _position = startPos;
      return null;
    }
  }

  // 0 --> typeof Expression
  // 1 --> ( Token
  // 2 --> identifer Token    or...   void Token    or...   Type object
  // 3 --> ) Token
  TypeOfExpression parseTypeOfExpression(){
    var output = TypeOfExpression(List());
    var startPos = _position;

    if(_tokens[_position].value == 'typeof'){
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position].value == '('){
        output.value.add(_tokens[_position]);
        _position++;
        if(_tokens[_position] is IdentifierToken){
          output.value.add(_tokens[_position]);
          _position++;
          if(_tokens[_position].value == ')'){
            output.value.add(_tokens[_position]);
            _position++;
            return output;
          }
          else{
            _position = startPos;
            return null;
          }
        }
        else if(_tokens[_position].value == 'void'){
           output.value.add(_tokens[_position]);
          _position++;
          if(_tokens[_position].value == ')'){
            output.value.add(_tokens[_position]);
            _position++;
            return output;
          }
          else{
            _position = startPos;
            return null;
          }
        }
        else{
          var type = parseType();
          if (type != null){
            output.value.add(type);
            if(_tokens[_position].value == ')'){
              output.value.add(_tokens[_position]);
              _position++;
              return output;
            }
            else{
              _position = startPos;
              return null;
            }
          }
          else{
            _position = startPos;
            return null;
          }
        }
      }
      else{
        _position = startPos;
        return null;
      }
    }
    else{
      return null;
    }
  }

  // 0 --> primary expression object    or...   0 --> type object
  // 1 --> . Token
  // 2 --> Identifier Token
  MemberAccess parseMemberAccessExpression(){
    var output = MemberAccess(List());
    var startPos = _position;
    var thisExpression = parseThisAccessExpression();
    if(thisExpression != null){
      output.value.add(thisExpression);
    }
    else{
      var type = parseType();
      if(type != null){
        output.value.add(type);
      }
      else{
        var name = parseSimpleName();
        if(name != null){
          output.value.add(name);
        }
        else{
          _position = startPos;
          return null;
        }
      }
    }
    if (_tokens[_position].value == '.'){
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position] is IdentifierToken){
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      }
      else{
        _position = startPos;
        return null;
      }
    }
    else{
      _position = startPos;
      return null;
    }
  }

  SimpleName parseSimpleName(){
	    var output = SimpleName(List());
	    if(_tokens[_position] is IdentifierToken){
	      output.value.add(_tokens[_position]);
	      _position++;
	      return output;
	    }
	    else{
	      return null;
	    }
	  }
	
	  Unary parseUnary(){
	    var output = Unary(List());
	    if(_tokens[_position].value == 'true' ||
	      _tokens[_position].value == 'false'){
	        output.value.add(_tokens[_position]);
	        _position++;
	        return output;
	      }
	      else{
	        return null;
	      }
	  }

  // 0 --> characterLiteral token or integerLiteral token or stringLiteral token
  Literal parseLiteralExpression(){
    var output = Literal(List());
    if (_tokens[_position].type == TokenType.characterLiteral ||
        _tokens[_position].type == TokenType.integerLiteral ||
        _tokens[_position].type == TokenType.stringLiteral ) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    return null;
  }

  // 0 --> ( Token
  // 1 --> Expression Token
  // 2 --> ) Token
  ParenthesizedExpression parseParenthizedExpression(){
    var output = ParenthesizedExpression(List());
    var startPos = _position;
    if (_tokens[_position].value == '(') {
      output.value.add(_tokens[_position]);
      _position++;
      //output.value.add(ParseExpression());
      var tmp3 = parseExpression();
      if (tmp3 != null) {
        output.value.add(tmp3);
        if (_tokens[_position].value == ')') {
          output.value.add(_tokens[_position]);
          _position++;
          return output;
        }
         else{
          _position = startPos;
          return null;
        }
        //_position++;
      } else {
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    return null;
  }

  // 0 --> primary expression object
  // or...
  // 0 --> assignment expression object
  // or...
  // 0 --> additive expression object
  // or...
  // 0 --> multiplicative expression object
  // or...
  // 0 --> equality expression object
  // or...
  // 0 --> relational expression object
  // or...
  // 0 --> conditional AND expression object
  // or...
  // 0 --> conditional OR expression object
  PrimaryNoArrayCreationExpression parseExpression(){
    var output;
    output = parsePrimaryExpression();
    if(output != null){
      return output;
    }
    else{
      output = parseAssignmentExpression();
      if(output!= null){
        return output;
      }
      else{
        output = parseAdditiveExpression();
        if(output != null){
          return output;
        }
        else{
          output = parseMultiplicativeExpression();
          if(output != null){
            return output;
          }
          else{
            output = parseEqualityExpression();
            if(output != null){
              return output;
            }
            else{
              output = parseRelationalExpression();
              if (output != null){
                return output;
              }
              else{
                output = parseConditionalAndExpression();
                if(output != null){
                  return output;
                }
                else{
                  output = parseConditionalOrExpression();
                  if(output != null){
                    return output;
                  }
                  else{
                    output = parseSimpleName();
                    if(output != null){
                      return output;
                    }
                    else{
                      output = parseUnary();
                      if(output != null){
                        return output;
                      }
                      else{
                        return null;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  // 0 --> primary expression object
  // 1 --> ( token
  // 2 to X --> identifier token   or...  expression object
  //            followed by a , token for every identifier or expression token
  // X + 2 --> ) token
  // helper methods for parseExpression()
  InvocationExpression parseInvocationExpression() {
    var output = InvocationExpression(List());
    var startPos = _position;
    var simple = parseSimpleName();
    if(simple != null){
      output.value.add(simple);
    } else {
      var literal = parseLiteralExpression();
      if (literal != null){
        output.value.add(literal);
      }
      else{
        var memAccess = parseMemberAccessExpression();
        if(memAccess != null){
          output.value.add(memAccess);
        }
        else{
          _position = startPos;
          return null;
        }
      }
    }
    if(_tokens[_position].value == '('){
      output.value.add(_tokens[_position]);
      _position++;
      while(_tokens[_position].value != ')'){
        if(_position >= _tokens.length) {
          _position = startPos;
          return null;
        }
        if(_tokens[_position] is IdentifierToken){
          output.value.add(_tokens[_position]);
          _position++;
          //this might be off, look here first when bug hunting
          if(_position < _tokens.length - 1){
            if(_tokens[_position].value == ',')
            {
              output.value.add(_tokens[_position]);
            }
            else{
              _position = startPos;
              return null;
            }
          }
        }
      }
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else {
      _position = startPos;
      return null;
    }
  }

  // broken
  // 0 --> new keyword Token
  // 1 --> Type object
  ObjectCreationExpression parseObjectCreationExpression() {
    var output = ObjectCreationExpression(List());
    var startPos = _position;
    if (_tokens[_position].value == "new" &&
        _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      if (parseType() != null) {
        output.value.add(_tokens[_position]);
        _position++;
        //argument list - optional
        if (_tokens[_position].value == '(') {
          while (_tokens[_position].value != ')') {
            output.value.add(_tokens[_position]);
            _position++;
          }
        }
        return output;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression
  // 1 --> = or....... Tokens (a bunch, look below)
  // 2 --> Expression
  AssignmentExpression parseAssignmentExpression() {
    var output = AssignmentExpression(List());
    var startPos = _position;
    var memberAccess = parseMemberAccessExpression();
    if(memberAccess != null){
      output.value.add(memberAccess);
    }
    else{
      var simple = parseSimpleName();
      if(simple != null){
        output.value.add(simple);
      }
      else{
        _position = startPos;
        return null;
      }
    }
    if (_tokens[_position].value == '=' ||
          _tokens[_position].value == '+=' ||
          _tokens[_position].value == '-=' ||
          _tokens[_position].value == '*=' ||
          _tokens[_position].value == '/=' ||
          _tokens[_position].value == '%=' ||
          _tokens[_position].value == '&=' ||
          _tokens[_position].value == '|=' ||
          _tokens[_position].value == '^=' ||
          _tokens[_position].value == '<<=') {
        output.value.add(_tokens[_position]);
        _position++;
        var member = parseMemberAccessExpression();
        if (member != null){
          output.value.add(member);
          return output;
        }
        else{
          var invoc = parseInvocationExpression();
          if(invoc != null){
            output.value.add(invoc);
            return output;
          }
          else{
            var obj = parseObjectCreationExpression();
            if(obj != null){
              output.value.add(invoc);
              return output;
            }
            else{
              var add = parseAdditiveExpression();
              if(add != null){
                output.value.add(add);
                return output;
              }
              else{
                var mult = parseMultiplicativeExpression();
                if(mult != null){
                  output.value.add(mult);
                  return output;
                }
                else{
                  var unary = parseUnary();
                  if(unary != null){
                    output.value.add(unary);
                    return output;
                  }
                  else{
                    var simple = parseSimpleName();
                    if(simple != null){
                      output.value.add(simple);
                      return output;
                    }
                    else{
                      var literal = parseLiteralExpression();
                      if(literal != null){
                        output.value.add(literal);
                        return output;
                      }
                      else{
                        _position = startPos;
                        return null;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        _position = startPos;
        return null;
      }
  }

  // 0 --> Expression object
  // 1 --> + or - Token
  // 2 --> Expression object
  AdditiveExpression parseAdditiveExpression() {
    var output = AdditiveExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '+' || _tokens[_position].value == '-') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression object
  // 1 --> * or / or % Token
  // 2 --> Expression object
  MultiplicativeExpression parseMultiplicativeExpression() {
    var output = MultiplicativeExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '*' ||
          _tokens[_position].value == '/' ||
          _tokens[_position].value == '%') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression object
  // 1 --> == or != Token
  // 2 --> Expression object
  EqualitylExpression parseEqualityExpression() {
    var output = EqualitylExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '==' || _tokens[_position].value == '!=') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression object
  // 1 --> < or > or <= or >= or is Token
  // 2 --> Expression object
  RelationalExpression parseRelationalExpression() {
    var output = RelationalExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '<' ||
          _tokens[_position].value == '>' ||
          _tokens[_position].value == '<=' ||
          _tokens[_position].value == '>=' ||
          _tokens[_position].value == 'is') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression object
  // 1 --> && Token
  // 2 --> Expression object
  ConditionalAndExpression parseConditionalAndExpression() {
    var output = ConditionalAndExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '&&') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 --> Expression
  // 1 --> || Token
  // 2 --> Expression
  ConditionalOrExpression parseConditionalOrExpression() {
    var output = ConditionalOrExpression(List());
    var startPos = _position;
    var tmpexp = parsePrimaryExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      //_position++;
      if (_tokens[_position].value == '||') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpexp = parsePrimaryExpression();
        if (tmpexp != null) {
          output.value.add(tmpexp);
          //_position++;
          return output;
        }
        _position = startPos;
        return null;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

  // 0 to X --> ClassDeclaration object
  Namespace parse() {
    var output = Namespace(new List());
    while (_position < _tokens.length) {
      var temp = parseClass();
      if (temp != null) {
        output.value.add(temp);
      } else {
        return null;
      }
    }
    return output;
  }
}
