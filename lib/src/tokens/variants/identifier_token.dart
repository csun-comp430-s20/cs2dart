import '../token.dart';

class IdentifierToken implements Token {

  IdentifierToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.identifier;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.identifier);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
   @override
  bool equals(Token token){
    return token.type == TokenType.identifier;
  }
}
