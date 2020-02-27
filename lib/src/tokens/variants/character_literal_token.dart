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

  String get value {
    return _value;
  }
}