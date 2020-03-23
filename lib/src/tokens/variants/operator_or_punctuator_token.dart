import '../token.dart';

class OperatorOrPunctuatorToken implements Token {

  OperatorOrPunctuatorToken(
    this._value,
  ): super();

  static final TokenType _type = TokenType.operatorOrPunctuator;
  final String _value;

  @override
  TokenType get type {
    assert(_type == TokenType.operatorOrPunctuator);
    return _type;
  }

  @override
  String get value {
    return _value;
  }
}
