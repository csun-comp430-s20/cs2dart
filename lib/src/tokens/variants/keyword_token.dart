import '../token.dart';

class KeywordToken extends Token {

  KeywordToken(
    this._id,
  );

  static final TokenType _type = TokenType.keyword;
  final String _id;

  @override
  TokenType get type {
    assert(_type == TokenType.keyword);
    return _type;
  }

  String get id {
    return _id;
  }
}
