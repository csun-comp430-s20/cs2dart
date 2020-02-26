enum SyntaxKind {
  //TEMP TOKENS
  NumberToken,
  WhitespaceToken,
  PlusToken,
  MinusToken,
  MultiplyToken,
  DivideToken,
  OpenParenToken,
  ClosedParenToken,
  ErrorToken,
  EOFToken,
  //END TEMP TOKENS

  keywordToken,
  integerLiteralToken,
  realLiteralToken,
  characterLiteralToken,
  stringLiteralToken,  
  interpolatedStringLiteralToken,
  operatorOrPunctorToken

}



class SyntaxToken {
  SyntaxToken(this.kind, this.position, this.text, this.value);

  SyntaxKind kind;
  int position;
  String text;
  Object value;
}
