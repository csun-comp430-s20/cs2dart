import '../token.dart';

class IntegerLiteralToken extends Token {

  IntegerLiteralToken(
    this._char,
  );

  static final TokenType _type = TokenType.integerLiteral;
  final int _char;

  @override
  TokenType get type {
    assert(_type == TokenType.integerLiteral);
    return _type;
  }

  @override
  int get char {
    return _char;
  }
}
