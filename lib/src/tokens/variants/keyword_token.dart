import '../token.dart';

class KeywordToken implements Token {

  KeywordToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.keyword;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.keyword);
    return _type;
  }

  String get value {
    return _value;
  }
}