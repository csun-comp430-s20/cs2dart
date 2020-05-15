import 'package:cs2dart/parser.dart';
import 'package:cs2dart/src/classes/classAST.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/expressions/primary_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/assignment_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/invocation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/object_creation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/parenthesized_expression.dart';
import 'package:cs2dart/src/expressions/variants/primary_no_array_creation_expression.dart';
import 'package:cs2dart/src/types/variants/reference_type.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/expressions.dart';

import 'dart:io';

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
import '../classes/variants/variants/ConstantDeclaration.dart';
import '../classes/variants/variants/ConstructorDeclaration.dart';
import '../classes/variants/variants/FieldDeclaration.dart';
import '../classes/variants/variants/MethodDeclaration.dart';
import '../classes/variants/ClassDeclaration.dart';
import '../classes/variants/ClassBase.dart';
import '../classes/variants/ClassModifier.dart';
import '../statements/variants/EmbeddedStatementVariants/expression_statement.dart';
import '../statements/variants/DeclarationStatementVariants/LocalVariableDeclarationVariants/LocalVariableDeclaratorsVariants/LocalVariableDeclaratorVariants/local_variable_initializer.dart';
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

  //seems done
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

  //wait for others to finish to finish class+interface methods
  ConstantDeclaration parseConstDeclaration() {
    var startPos = _position;
    var output = ConstantDeclaration(new List());
    if (_tokens[_position].value == 'const') {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position] is KeywordToken) {
        //if(isType())
      } else {
        _position = startPos;
        return null;
      }
    } else {
      return null;
    }
  }

  FieldDeclaration parseFieldDeclaration() {}

  MethodDeclaration parseMethodDeclaration() {}

  ConstructorDeclaration parseConstructorDeclaration() {}

  //done, need to finish helper methods
  ClassBody parseClassBody() {
    var startPos = _position;
    var output = ClassBody(new List());
    if (_tokens[_position] is OperatorOrPunctuatorToken &&
        _tokens[_position].value == '{') {
      output.value.add(_tokens[_position]);
      _position++;
      while (_tokens[_position].value != '}') {
        //if end of list without braket return null
        if (_position > _tokens.length) {
          _position = startPos;
          return null;
        }
        var constDecl = parseConstDeclaration();
        if (constDecl != null) {
          output.value.add(constDecl);
        } else {
          var fieldDecl = parseFieldDeclaration();
          if (fieldDecl != null) {
            output.value.add(fieldDecl);
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

  ClassDeclaration parseClass() {
    var startPos = _position;
    var output = ClassDeclaration(new List());
    //class modifier COME BACK TO THIS
    // if(_tokens[_position] is KeywordToken && _tokens[_position].value != 'class'){

    // }
    //class keyword
    if (_tokens[_position] is KeywordToken &&
        _tokens[_position].value == 'class') {
      output.value.add(_tokens[_position]);
      _position++;
      //identifier
      if (_tokens[_position] is IdentifierToken) {
        output.value.add(_tokens[_position]);
        _position++;

        //class base
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
          if (_tokens[_position] is OperatorOrPunctuatorToken &&
              _tokens[_position].value == ';') {
            output.value.add(_tokens[_position]);
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

  //finish
  InterfaceBody parseInterfaceBody() {
    return null;
  }

  // InterfaceModifier parseInterfaceModifier(){
  //   return null;
  // }
  //seems done
  InterfaceBase parseInterfaceBase() {
    var startPos = _position;
    var output = InterfaceBase(new List());
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

  //Seems done
  InterfaceDeclaration parseInterface() {
    var startPos = _position;
    var output = InterfaceDeclaration(new List());
    //interface modifier COMEBACK TO THIS
    // if(_tokens[_position] is KeywordToken && _tokens[_position].value != 'interface'){

    // }
    //interface keyword
    if (_tokens[_position] is KeywordToken &&
        _tokens[_position].value == 'interface') {
      output.value.add(_tokens[_position]);
      _position++;
      var body = parseInterfaceBody();
      //interface Body
      if (body != null) {
        output.value.add(body);
        _position++;
        if (_tokens[_position] is OperatorOrPunctuatorToken &&
            _tokens[_position].value == ';') {
          output.value.add(_tokens[_position]);
          _position++;
          return output;
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
  }

  //=================================================================================
  //=================================================================================
  //Start of parsers for Statements==================================================
  //=================================================================================
  //=================================================================================
  
  //

  LocalVariableInitializer parseLocalVariableInitializer()
  {
    var tmpExp = parseExpression();

    var output = LocalVariableInitializer(List());
    if (tmpExp != null) {
      output.value.add(tmpExp);
      return output;
    }
    else{
      return null;
    }
  }


  
   LocalVariableDeclarator parseLocalVariableDeclarator()
  {
    var startPos = _position;
    var output = LocalVariableDeclarator(List());
    if (_tokens[_position].type == TokenType.identifier) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '=') {
        output.value.add(_tokens[_position]);
        _position++;
        var tmpLocVarInit = parseLocalVariableInitializer();
        if(tmpLocVarInit != null){
          output.value.add(tmpLocVarInit);
          return output;
        }
        else{
          _position = startPos;
          return null;
        }
      }
      else
      {
        return output;
      }
    }
    _position = startPos;
    return null;
  }

  LocalVariableDeclarators parseLocalVariableDeclarators() {
    var startPos = _position;
    var output = LocalVariableDeclarators(List());
    var tmpVarDec = parseLocalVariableDeclarator();
    if (tmpVarDec != null) {
      output.value.add(tmpVarDec);
      _position++;
      if (_tokens[_position].value == ',') {
        output.value.add(_tokens[_position]);
        _position++;
        var moretmpVarDec = parseLocalVariableDeclarators();
        if (moretmpVarDec != null) {
          output.value.add(moretmpVarDec);
          _position++;
          return output;
        }
        _position = startPos;
        return null;
      } else {
        return output;
      }
    }
    _position = startPos;
    return null;
  }

  LocalVariableType parseLocalVariableType() {
    var startPos = _position;
    var output = LocalVariableType(List());
    var tmpType = parseType();
    if (tmpType != null) {
      output.value.add(tmpType);
      _position++;
      return output;
    }
    _position = startPos;
    return null;
  }

  LocalVariableDeclaration parseLocalVariableDeclaration() {
    var startPos = _position;
    var output = LocalVariableDeclaration(List());
    var newLocalVarType = parseLocalVariableType();
    if (newLocalVarType != null) {
      output.value.add(newLocalVarType);
      _position++;
      var newLocalVarDec = parseLocalVariableDeclarators();
      if (newLocalVarDec != null) {
        output.value.add(newLocalVarDec);
        _position++;
        return output;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    return null;
  }

   ConstantDeclaration parseConstantDeclaration() {
    var startPos = _position;
    var output = ConstantDeclaration(List());
    if (_tokens[_position].value == "const") {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].type == TokenType.identifier) {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position].value == "=") {
          output.value.add(_tokens[_position]);
          _position++;
          var tmpExpr = parseExpression();
          if (tmpExpr != null)
          {
            output.value.add(tmpExpr);
            _position++;
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
    _position = startPos;
    return null;
  }
//====================================================================
//top level parsers for Statements====================================
//====================================================================

  LabeledStatement parseLabeledStatement() {
    var startPos = _position;
    var output = LabeledStatement(List());
    if (_tokens[_position].type == TokenType.identifier) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == ':') {
        output.value.add(_tokens[_position]);
        _position++;
        var newStat = parseStatements();
        if (newStat != null) {
          output.value.add(_tokens[_position]);
          _position++;
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

  ExpressionStatement parseExpressionStatement(){
    var startPos = _position;
    var output = ExpressionStatement(new List());
    var expression = parseInvocationExpression();
    if(expression == null){
      expression = parseObjectCreationExpression();
      if(expression == null){
        expression = parseAssignmentExpression();
        if (expression == null){
          return null;
        }
      }
    }
    output.value.add(expression);
    if(_tokens[_position].value == ';'){
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    else{
      return null;
    }
  }


  
  ForStatement parseForStatement() {
    var startPos = _position;
    var output = ForStatement(new List());
    if (_tokens[_position].value == 'for') {
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position].value == '('){
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
      return null;
    }
  }
   
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
        if(boolean != null){
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

  SelectionStatement parseSelectionStatement() {
    var startPos = _position;
    var output = SelectionStatement(new List());
    if (_tokens[_position].value == 'if') {
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position].value == '('){
        var boolean = parseExpression();
        if(boolean != null){
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

  //====================================================================
  //Main parser for Statements==========================================
  //====================================================================

  Statement parseStatements() {
    Statement output;
    output = parseLabeledStatement();
    if (output != null) {
      return output;
    } else {
      output = parseDeclarationStatement();
      if (output != null) {
        return output;
      } else {
        output = parseEmbeddedStatement();
        return output;
      }
    }
  }

  //=================================================================================
  //=================================================================================
  //end of parsers for Statements====================================================
  //=================================================================================
  //=================================================================================

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

  ReferenceType parseReferenceType() {
    var output = ReferenceType(new List());
    if (_tokens[_position].value == 'object') {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    } else if (_tokens[_position].value == 'dynamic') {
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

  PrimaryExpression parseExpression() {
    /*
      NOT SUPPORTED:
      alias
      element access not supported because there is no array support
      'base' keyword 
      post decrement and increment
      anonymous object creation
      delegate
      checked vs unchecked - tentative
      default values -  tentative
      nameof - tentative
    */
    //TODO: make proper fail states and add returns and fix compile error with parstyle paramater
    int startPos = _position;
    PrimaryNoArrayCreationExpression output =
        PrimaryNoArrayCreationExpression(List());
    //literals
    if (_tokens[_position].type == TokenType.characterLiteral ||
        _tokens[_position].type == TokenType.integerLiteral ||
        _tokens[_position].type == TokenType.stringLiteral) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    _position = startPos;
    //parenthesized expression
    if (_tokens[_position].value == '(') {
      output.value.add(_tokens[_position]);
      _position++;
      //output.value.add(ParseExpression());
      var tmp3 = parseExpression();
      if (tmp3 != null) {
        output.value.add(tmp3);
        _position++;
      }
      if (_tokens[_position].value == ')') {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      }
      _position = startPos;
      return null;
    }
    _position = startPos;
    //member access
    //may need a helper method
    if (_tokens[_position] is PrimaryExpression || parseType() != null) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '.') {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position] is IdentifierToken) {
          output.value.add(_tokens[_position]);
          _position++;
          //argument list - optional
          if (_tokens[_position].value == '<') {
            while (_tokens[_position].value != '>') {
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
    }
    _position = startPos;

    var tmp = parseInvocationExpression();
    if (tmp != null) {
      output.value.add(tmp);
      _position++;
      return output;
    }
    _position = startPos;
    //'this' access
    if (_tokens[_position].value == "this" &&
        _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }

    var tmp2 = parseObjectCreationExpression();
    if (tmp != null) {
      output.value.add(tmp2);
    }
    _position = startPos;

    //typof
    if (_tokens[_position].value == "typeof" &&
        _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position].value == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position].value == "void" ||
            _tokens[_position] is IdentifierToken) {
          output.value.add(_tokens[_position]);
          _position++;
          if (_tokens[_position].value == ')') {
            output.value.add(_tokens[_position]);
            _position++;
            return output;
          }
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

  //helper methods for parseExpression()
  PrimaryExpression parseInvocationExpression() {
    InvocationExpression output = InvocationExpression(List());
    int startPos = _position;
    if (_tokens[_position] is PrimaryExpression) {
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

  PrimaryExpression parseObjectCreationExpression() {
    ObjectCreationExpression output = ObjectCreationExpression(List());
    int startPos = _position;
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

  PrimaryExpression parseAssignmentExpression() {
    AssignmentExpression output = AssignmentExpression(List());
    int startPos = _position;
    var tmpexp = parseExpression();
    if (tmpexp != null) {
      output.value.add(tmpexp);
      _position++;
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
        var tmpexp2 = parseExpression();
        if (tmpexp2 != null) {
          output.value.add(tmpexp2);
          _position++;
          return output;
        }
        _position = startPos;
      }
      _position = startPos;
    }
    _position = startPos;
    return null;
  }
}
