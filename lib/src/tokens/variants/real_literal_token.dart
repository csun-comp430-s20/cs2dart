import '../token.dart';

class RealLiteralToken implements Token {

  RealLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.realLiteral;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.realLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
   @override
  bool equals(Token token){
    return token.type == TokenType.realLiteral;
  }
}
