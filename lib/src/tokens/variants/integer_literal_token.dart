import '../token.dart';

class IntegerLiteralToken implements Token {

  IntegerLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.integerLiteral;
  final int _value;

  @override
  TokenType get type {
    assert(_type == TokenType.integerLiteral);
    return _type;
  }

  int get value {
    return _value;
  }
}
