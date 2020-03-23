import '../token.dart';

class CharacterLiteralToken implements Token {

  CharacterLiteralToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.characterLiteral;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.characterLiteral);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Token token){
    return token.type == TokenType.characterLiteral;
  }
}
