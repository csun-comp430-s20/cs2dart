enum SyntaxKind {
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
}

class SyntaxToken {
  SyntaxToken(this.kind, this.position, this.text, this.value);

  SyntaxKind kind;
  int position;
  String text;
  Object value;
}
