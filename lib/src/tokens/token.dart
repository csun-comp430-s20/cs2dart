enum TokenType {
  characterLiteral,
  identifier,
  integerLiteral,
  interpolatedStringLiteral,
  keyword,
  operatorOrPunctuator,
  realLiteral,
  stringLiteral,
}

abstract class Token {

  Token(
    this.type,
  );

  final TokenType type;

}
