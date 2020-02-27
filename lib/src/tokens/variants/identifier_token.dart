import '../token.dart';

class IdentifierToken extends Token {

  IdentifierToken(
    this._id
  );

  static final TokenType _type = TokenType.identifier;
  final String _id;

  @override
  TokenType get type {
    assert(_type == TokenType.identifier);
    return _type;
  }

  String get id {
    return _id;
  }
}
