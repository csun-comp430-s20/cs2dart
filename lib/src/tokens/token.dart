enum TokenType {
  characterLiteral,
  identifier,
  integerLiteral,
  interpolatedStringLiteral,
  keyword,
  operatorOrPunctuator,
  realLiteral,
  stringLiteral,
  error,
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
}
