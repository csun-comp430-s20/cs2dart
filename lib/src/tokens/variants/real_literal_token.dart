import '../token.dart';

class RealLiteralToken implements Token {

  RealLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.realLiteral;
  final double _value;

  @override
  TokenType get type {
    assert(_type == TokenType.realLiteral);
    return _type;
  }

  double get value {
    return _value;
  }
}
