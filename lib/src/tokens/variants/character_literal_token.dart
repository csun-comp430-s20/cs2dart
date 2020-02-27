import '../token.dart';

class CharacterLiteralToken implements Token {

  CharacterLiteralToken(
    this._char,
    this._rep
  );

  static final TokenType _type = TokenType.characterLiteral;
  final int _char;
  final String _rep;

  @override
  TokenType get type {
    assert(_type == TokenType.characterLiteral);
    return _type;
  }

  @override
  int get char {
    return _char;
  }

  @override
  String get rep {
    return _rep;
  }
}
