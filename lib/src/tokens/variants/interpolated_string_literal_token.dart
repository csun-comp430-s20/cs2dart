import '../token.dart';

class InterpolatedStringLiteralToken extends Token {

  InterpolatedStringLiteralToken(
    this._char,
    this._rep
  );

  static final TokenType _type = TokenType.interpolatedStringLiteral;
  final int _char;
  final String _rep;

  @override
  TokenType get type {
    assert(_type == TokenType.interpolatedStringLiteral);
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
