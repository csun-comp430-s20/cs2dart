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

  test('Simple assignment test', () {
    var line = Lexer('boolean x = !false;');
    var list = line.lexify();

    expect('boolean', list[0].value);
    expect('x', list[1].value);
    expect('=', list[2].value);
    expect('!', list[3].value);
    expect('false', list[4].value);
    expect(';', list[5].value);
  });

  test("Full 'if' test", () {

    var line = Lexer('if (True) { int x = 0; } else { int y = 1;}');
    var list = line.lexify();

    expect('if', list[0].value);
    expect('(', list[1].value);
    expect('True', list[2].value);
    expect(')', list[3].value);
    expect('{', list[4].value);
    expect('int', list[5].value);
    expect('x', list[6].value);
    expect('=', list[7].value);
    expect('0', list[8].value);
    expect(';', list[9].value);
    expect('}', list[10].value);
    expect('else', list[11].value);
    expect('{', list[12].value);
    expect('int', list[13].value);
    expect('y', list[14].value);
    expect('=', list[15].value);
    expect('1', list[16].value);
    expect(';', list[17].value);
    expect('}', list[18].value);
  });
}
