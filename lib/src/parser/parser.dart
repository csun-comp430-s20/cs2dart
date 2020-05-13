import 'package:cs2dart/parser.dart';
import 'package:cs2dart/src/classes/classAST.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/types/type_assist.dart';
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
import '../tokens/variants/identifier_token.dart';
import '../tokens/variants/integer_literal_token.dart';
import '../tokens/variants/keyword_token.dart';
import '../tokens/variants/operator_or_punctuator_token.dart';


class Parser {
  Parser(this._tokens);

  final List<Token> _tokens;
  int _position = 0;

  // Token peek(int offset) {
  //   var index = _position + offset;
  //   if (index >= _tokens.length) {
  //     return _tokens[_tokens.length - 1];
  //   }
  //   return _tokens[index];
  // }

  void checkTokenIs(int position, Token input) {
    // equals written, need to test, unsure why error
    if (!_tokens[position].equals(input)) {
      throw ParseException('Expected: ' +
          input.toString() +
          'Received: ' +
          _tokens[position].toString());
    }
  }

  // ParseResult parseAdditiveExpHelper(final int startPos){
  //   final List<Exp> resultList  = new List<Exp>;
  //   int curPos = startPos;
  //   while(curPos < _tokens.length){
  //     try{
  //       checkTokenIs(curPos, new PlusToken)
  //     }
  //   }
  // }

  ParseResult<Exp> parseAdditiveExp(final int startPos) {
    final ParseResult<Exp> starting = parsePrimary(startPos);
    return null;
  }

  ParseResult parsePrimary(int startPos) {
    return null;
  }

  ParseResult<Exp> _parseType(final int startPos) {}

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

  bool _isType(KeywordToken input){
    if (input.value =='bool' ||
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
        input.value == 'ushort'){
          return true;
        }
        else{
          return false;
        }
  }
  //end interface helper functions

  //start class helper functions
  // bool _isClassModifier(KeywordToken input) {
  //   //modify to check for repeats
  //   if (input.value == 'new' ||
  //       input.value == 'public' ||
  //       input.value == 'protected' ||
  //       input.value == 'internal' ||
  //       input.value == 'private' ||
  //       input.value == 'abstract' ||
  //       input.value == 'static') {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //end class helper functions

  //start Expressions helper funtions

  //end Expressions helper funtions

  //seems done
  ClassBase parseClassBase() {
    var startPos = _position;
    var output = ClassBase(new List());
    if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == ':'){
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

  //wait for others to finish to finish class+interface methods
  ConstantDeclaration parseConstDeclaration(){
    var startPos = _position;
    var output = ConstantDeclaration(new List());
    if(_tokens[_position].value == 'const'){
      output.value.add(_tokens[_position]);
      _position++;
      if(_tokens[_position] is KeywordToken){
        if(isType())
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

  FieldDeclaration parseFieldDeclaration(){

  }

  MethodDeclaration parseMethodDeclaration(){

  }

  ConstructorDeclaration parseConstructorDeclaration(){

  }

  //done, need to finish helper methods
  ClassBody parseClassBody(){
    var startPos = _position;
    var output = ClassBody(new List());
    if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == '{'){
      output.value.add(_tokens[_position]);
      _position++;
      while(_tokens[_position].value != '}'){
        //if end of list without braket return null
        if(_position > _tokens.length){
          _position = startPos;
          return null;
        }
        var constDecl = parseConstDeclaration();
        if(constDecl != null){
          output.value.add(constDecl);
        }
        else{
          var fieldDecl = parseFieldDeclaration();
          if (fieldDecl != null){
            output.value.add(fieldDecl);
          }
          else{
            var methodDecl = parseMethodDeclaration();
            if (methodDecl != null){
              output.value.add(methodDecl);
            }
            else{
              var constructorDecl = parseConstructorDeclaration();
              if (constructorDecl != null){
                output.value.add(constructorDecl);
              }
              else{
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
    }
    else{
      _position = startPos;
      return null;
    }
    
  }


  ClassDeclaration parseClass(){
    var startPos = _position;
    var  output = ClassDeclaration(new List());
    //class modifier COME BACK TO THIS
    // if(_tokens[_position] is KeywordToken && _tokens[_position].value != 'class'){

    // }
    //class keyword
    if(_tokens[_position] is KeywordToken && _tokens[_position].value == 'class'){
      output.value.add(_tokens[_position]);
      _position++;
      //identifier
      if(_tokens[_position] is IdentifierToken){
        output.value.add(_tokens[_position]);
        _position++;
        
        //class base
        if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == ':'){
          var classBase = parseClassBase();
          if(classBase == null){
            _position = startPos;
            return null;
          }
          else{
            output.value.add(classBase);
          }
        }
        //class body
        var body = parseClassBody();
        if(body != null){
          output.value.add(body);
          if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == ';' ){
            output.value.add(_tokens[_position]);
          }
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

  //finish
  InterfaceBody parseInterfaceBody(){
    return null;
  }

  // InterfaceModifier parseInterfaceModifier(){
  //   return null;
  // }
    //seems done
    InterfaceBase parseInterfaceBase(){
    var startPos = _position;
    var output = InterfaceBase(new List());
    if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == ':'){
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

  //Seems done
  InterfaceDeclaration parseInterface(){
    var startPos = _position;
    var output = InterfaceDeclaration(new List());
    //interface modifier COMEBACK TO THIS
    // if(_tokens[_position] is KeywordToken && _tokens[_position].value != 'interface'){

    // }
    //interface keyword
    if(_tokens[_position] is KeywordToken && _tokens[_position].value == 'interface'){
      output.value.add(_tokens[_position]);
      _position++;
      var body = parseInterfaceBody();
      //interface Body
      if(body != null){
       output.value.add(body);
       _position++;
       if(_tokens[_position] is OperatorOrPunctuatorToken && _tokens[_position].value == ';'){
         output.value.add(_tokens[_position]);
         _position++;
         return output;
       }
       else{
         return output;
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

  ParseResult<Exp> parseExp(final int startPos) {
    var currPos = startPos;
    /*
    array_creation_expression
    examples:
    new int[3]
    new int[3] { 10, 20, 30 }
    new int[] { 10, 20, 30 }
    new[] { 10, 20, 30 }

    currently supports array creation in the form of: new _datatype_ [_sizeinteger_]
    our current documentation doesn't detail array creation that much and the c# docs i feel contain features we don't need
    */
    if (_tokens[currPos].value == 'new' && _tokens[currPos] is KeywordToken) {
      currPos++;
      if (_tokens[currPos] is KeywordToken ||
          _tokens[currPos] is IdentifierToken) {
        //using keyword token and identifierToken bc the array could be of ANY data type
        //Todo maybe make an isClass or classToken bc currently this will pass keywords that aren't data types
        currPos++;
        if (_tokens[currPos].value == '[') {
          currPos++;
          if (_tokens[currPos].value == ']') {
            currPos++;
            if (_tokens[currPos].value == '{') {
              currPos++;
              while (_tokens[currPos].value != '}') {
                //TODO: make the expression fail if the elements do not match the type. currently this only works for integers
                if (_tokens[currPos] is IntegerLiteralToken) {
                  currPos++;
                  if (_tokens[currPos].value == ',') {
                    currPos++;
                  }
                }
              }
            }
          }
          if (_tokens[currPos] is IntegerLiteralToken) {
            int array_declared_size = _tokens[currPos].value as int;
            currPos++;
            if (_tokens[currPos].value == ']') {
              currPos++;
              if (_tokens[currPos].value == '{') {
                currPos++;
                int array_size = 0;
                while (_tokens[currPos].value != '}') {
                  //TODO: make the expression fail if the elements do not match the type. currently this only works for integers
                  if (_tokens[currPos] is IntegerLiteralToken) {
                    currPos++;
                    array_size++;
                    if (_tokens[currPos].value == ',') {
                      currPos++;
                    }
                  }
                }
                if (array_declared_size != array_size || array_size != 0) {
                  return null;
                }
              }
            }

          } else {
            return null;
          }
        }
      }
    } else {
      return null;
    }
    // if (_tokens[startPos] is IdentifierToken) {

    // } else if (_tokens[startPos] is KeywordToken) {

    // } else if (_tokens[startPos] is RealLiteralToken) {

    // } else if (_tokens[startPos] is IntegerLiteralToken) {

    // } else if (_tokens[startPos] is InterpolatedStringLiteralToken) {

    // } else if (_tokens[startPos] is StringLiteralToken) {

    // } else if (_tokens[startPos] is CharacterLiteralToken) {

    // } else if (_tokens[startPos] is OperatorOrPunctuatorToken) {

    // }
    var result = _parseType(startPos);

    if (result != null) {
      return result;
    } else {
      throw ParseException('Unrecognized token in parser.');
    }
  }

  // Top level expressions file entrance
  Exp parseToplevelExp() {
    // try {
    //   final result = parseExp(0);
    //
    //   if (result.nextPos == _tokens.length) {
    //     return result.result;
    //   } else {
    //     throw ParseException('Extra tokens at end');
    //   }
    // } on ParseException catch (e) {
    //   stdout.writeln('$e');
    //   exit(1);
    // }
  }

}
