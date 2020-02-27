import '../token.dart';

class StringLiteralToken extends Token {

  StringLiteralToken(
    this._char,
    this._rep
  );

  static final TokenType _type = TokenType.stringLiteral;
  final int _char;
  final String _rep;

  @override
  TokenType get type {
    assert(_type == TokenType.stringLiteral);
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
