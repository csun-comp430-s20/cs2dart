import 'package:cs2dart/parser.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/expr.dart';

import '../../parser.dart';
import '../../parser.dart';
import '../../parser.dart';
import '../../parser.dart';
import '../../parser.dart';
import '../tokens/variants/integer_literal_token.dart';
import '../tokens/variants/operator_or_punctuator_token.dart';

class Parser {
  Parser(this._tokens);

  final List<Token> _tokens;
  int _position;

  Token peek(int offset) {
    var index = _position + offset;
    if (index >= _tokens.length) {
      return _tokens[_tokens.length - 1];
    }
    return _tokens[index];
  }

  void checkTokenIs(int position, Token input) {
    //equals written, need to test, unsure why error
    if (!_tokens[_position].equals(input)) {
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
    final rest = parseAdditiveExp(starting.nextPos) as ParseResult<List<Exp>>;
    Exp resultExp = starting.result;

    rest.result
        .forEach((otherExp) => resultExp = PlusExp(resultExp, otherExp));
    return ParseResult(resultExp, rest.nextPos);
  }

  ParseResult parsePrimary(int startPos) {
    if (_tokens[startPos] is IdentifierToken) {
      final asVar = _tokens[startPos] as IdentifierToken;
      return ParseResult(VariableExp(asVar.type as String), startPos + 1);
    }
    else if (_tokens[startPos] is IntegerLiteralToken){
      final asInt = _tokens[startPos] as IntegerLiteralToken;
      return ParseResult(IntegerExp(asInt.value as int), startPos + 1);
    }
    else {
      checkTokenIs(startPos, OperatorOrPunctuatorToken('('));
      final ParseResult<Exp> inner = parseExp(startPos + 1);
      checkTokenIs(inner.nextPos, OperatorOrPunctuatorToken(')'));
      return ParseResult<Exp>(inner.result, inner.nextPos + 1);
    }
  }
  ParseResult parseExp(int startPos){
    // TO DO
    return ParseResult<Exp>(0 as Exp,0);
  }
}
