import '../token.dart';

class ErrorToken implements Token {

  ErrorToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.error;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.error);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
}
