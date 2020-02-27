import '../token.dart';

class OperatorOrPunctuatorToken extends Token {

  OperatorOrPunctuatorToken(
    this._char,
    this._rep
  );

  static final TokenType _type = TokenType.operatorOrPunctuator;
  final int _char;
  final String _rep;

  @override
  TokenType get type {
    assert(_type == TokenType.operatorOrPunctuator);
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
