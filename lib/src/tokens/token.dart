enum TokenType {
  characterLiteral,
  identifier,
  integerLiteral,
  interpolatedStringLiteral,
  keyword,
  operatorOrPunctuator,
  realLiteral,
  stringLiteral,
}

abstract class Token {

  Token(
    this._type,
    this._value,
  );

  final TokenType _type;
  final String _value;

  TokenType get type {
    return _type;
  }

  String get value {
    return _value;
  }

  // To Do: Test this function 
  bool equals(Token token){
    return _type == token.type;
  }
}
