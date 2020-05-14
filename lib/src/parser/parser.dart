import 'package:cs2dart/parser.dart';
import 'package:cs2dart/src/classes/classAST.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/expressions/primary_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/parenthesized_expression.dart';
import 'package:cs2dart/src/types/type_assist.dart';
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
import '../classes/classAST.dart';
import '../classes/variants/ClassBody.dart';
import '../classes/variants/variants/ConstantDeclaration.dart';
import '../classes/variants/variants/ConstructorDeclaration.dart';
import '../classes/variants/variants/FieldDeclaration.dart';
import '../classes/variants/variants/MethodDeclaration.dart';
import '../classes/variants/ClassDeclaration.dart';
import '../classes/variants/ClassBase.dart';
import '../classes/variants/ClassModifier.dart';
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

  PrimaryExpression ParseExpression() {
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
    PrimaryExpression output = PrimaryExpression(List());
    //literals
    if (_tokens[_position] == TokenType.characterLiteral ||
        _tokens[_position] == TokenType.integerLiteral ||
        _tokens[_position] == TokenType.stringLiteral) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    //parenthesized expression
    if (_tokens[_position] == '(') {
      _position++;
      ParenthesizedExpression parenExpression = ParseParenthesizedExpression();
      if (_tokens[_position] == ')') {
        output.value.add(_tokens[_position]);
        _position++;
        return output;
      }
    }
    //member access
    //may need a helper method
    if (_tokens[_position] is PrimaryExpression ||
        parseType(_position) != null) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position] == '.') {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position] is IdentifierToken) {
          output.value.add(_tokens[_position]);
          _position++;
          //argument list - optional
          if (_tokens[_position] == '<') {
            while (_tokens[_position] != '>') {
              output.value.add(_tokens[_position]);
              _position++;
            }
          }
          return output;
        }
      }
    }
    //invocation expression
    if (_tokens[_position] is PrimaryExpression) {
      output.value.add(_tokens[_position]);
      _position++;
      //argument list - optional
      if (_tokens[_position] == '(') {
        while (_tokens[_position] != ')') {
          output.value.add(_tokens[_position]);
          _position++;
        }
      }
      return output;
    }
    //'this' access
    if (_tokens[_position] == "this" && _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      return output;
    }
    //object creation
    if (_tokens[_position] == "new" && _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      if (parseType(_position) != null) {
        output.value.add(_tokens[_position]);
        _position++;
        //argument list - optional
        if (_tokens[_position] == '(') {
          while (_tokens[_position] != ')') {
            output.value.add(_tokens[_position]);
            _position++;
          }
        }
        return output;
      }
    }
    //typof
    if (_tokens[_position] == "typeof" && _tokens[_position] is KeywordToken) {
      output.value.add(_tokens[_position]);
      _position++;
      if (_tokens[_position] == '(') {
        output.value.add(_tokens[_position]);
        _position++;
        if (_tokens[_position] == "void" ||
            _tokens[_position] is IdentifierToken) {
          output.value.add(_tokens[_position]);
          _position++;
          if (_tokens[_position] == ')') {
            output.value.add(_tokens[_position]);
            _position++;
            return output;
          }
        }
      }
    }
    return null;
  }

  ParenthesizedExpression ParseParenthesizedExpression() {
    return null;
  }
}
