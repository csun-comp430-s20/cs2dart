import '../token.dart';

class StringLiteralToken implements Token {

  StringLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.stringLiteral;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.stringLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

   @override
  bool equals(Token token){
    return token.type == TokenType.stringLiteral;
  }
}