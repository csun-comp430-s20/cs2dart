import '../token.dart';

class IntegerLiteralToken implements Token {

  IntegerLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.integerLiteral;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.integerLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
}
