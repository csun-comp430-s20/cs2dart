import 'package:cs2dart/lexer.dart';

import 'package:cs2dart/tokens.dart';

import 'package:test/test.dart';

void main() {

  test("The 'hello' utf16 test", () {
    var token = Lexer('hello').nextToken();
    expect(TokenType.identifier, token.type);
  });

  test("The 'return' utf16 test", () {
    var token = Lexer('return').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'if' utf16 test", () {
    var token = Lexer('if').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'protected' utf16 test", () {
    var token = Lexer('protected').nextToken();
    expect(TokenType.keyword, token.type);
  });
}