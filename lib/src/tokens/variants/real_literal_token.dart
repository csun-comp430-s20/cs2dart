import '../token.dart';

class RealLiteralToken extends Token {

  RealLiteralToken(
    this._char,
    this._rep
  );

  static final TokenType _type = TokenType.realLiteral;
  final double _char;
  final String _rep;

  @override
  TokenType get type {
    assert(_type == TokenType.realLiteral);
    return _type;
  }

  @override
  double get char {
    return _char;
  }

  @override
  String get rep {
    return _rep;
  }
}
