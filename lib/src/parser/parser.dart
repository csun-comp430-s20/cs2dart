import 'package:cs2dart/parser.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/expressions.dart';

import 'dart:io';

class Parser {

  Parser(this._tokens);

  final List<Token> _tokens;
  // int _position = 0;

  // Token peek(int offset) {
  //   var index = _position + offset;
  //   if (index >= _tokens.length) {
  //     return _tokens[_tokens.length - 1];
  //   }
  //   return _tokens[index];
  // }

  void checkTokenIs(int position, Token input){
    // equals written, need to test, unsure why error
    if(!_tokens[position].equals(input)) {
      throw ParseException('Expected: ' + input.toString() + 'Received: ' + _tokens[position].toString());
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

  ParseResult parsePrimary(int startPos){
    return null;
  }

  ParseResult<Exp> _parseType(final int startPos) {

  }

  ParseResult<Exp> parseExp(final int startPos) {
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
    }
    
    else {
      throw ParseException('Unrecognized token in parser.');
    }
  }

  // Top level expressions file entrance
  Exp parseToplevelExp() {
    try {
      final result = parseExp(0);

      if (result.nextPos == _tokens.length) {
        return result.result;
      } else {
          throw ParseException('Extra tokens at end');
      }
    } on ParseException catch (e) {
      stdout.writeln('$e');
      exit(1);
    }
  }
}
