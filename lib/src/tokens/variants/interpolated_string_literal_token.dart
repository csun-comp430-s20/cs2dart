import '../token.dart';

class InterpolatedStringLiteralToken implements Token {

  InterpolatedStringLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.interpolatedStringLiteral;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.interpolatedStringLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
}
