import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';

import 'package:test/test.dart';

void main() {

  test("The 'hello' utf16 test", () {
    var token = Lexer('hello').nextToken();
    expect(TokenType.identifier, token.type);
  });

  //keyword tests

  test("The 'as' utf16 test", () {
    var token = Lexer('as').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'bool' utf16 test", () {
    var token = Lexer('bool').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'break' utf16 test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'byte' utf16 test", () {
      var token = Lexer('byte').nextToken();
      expect(TokenType.keyword, token.type);
    });

  test("The 'case' utf16 test", () {
    var token = Lexer('case').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'char' utf16 test", () {
    var token = Lexer('char').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'class' utf16 test", () {
    var token = Lexer('class').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'const' utf16 test", () {
    var token = Lexer('const').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'continue' utf16 test", () {
    var token = Lexer('continue').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'decimal' utf16 test", () {
    var token = Lexer('decimal').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'do' utf16 test", () {
    var token = Lexer('do').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'double' utf16 test", () {
    var token = Lexer('double').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'else' utf16 test", () {
    var token = Lexer('else').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'false' utf16 test", () {
    var token = Lexer('false').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'float' utf16 test", () {
    var token = Lexer('float').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'for' utf16 test", () {
    var token = Lexer('for').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'foreach' utf16 test", () {
    var token = Lexer('foreach').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'if' utf16 test", () {
    var token = Lexer('if').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'in' utf16 test", () {
    var token = Lexer('in').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'intbreak' utf16 test", () {
    var token = Lexer('int').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'interface' utf16 test", () {
    var token = Lexer('interface').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'internal' utf16 test", () {
    var token = Lexer('internal').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'protected' utf16 test", () {
    var token = Lexer('protected').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'is' utf16 test", () {
    var token = Lexer('is').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'long' utf16 test", () {
    var token = Lexer('long').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'new' utf16 test", () {
    var token = Lexer('new').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'null' utf16 test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'object' utf16 test", () {
    var token = Lexer('object').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'private' utf16 test", () {
    var token = Lexer('private').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'public' utf16 test", () {
    var token = Lexer('protected').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'private' utf16 test", () {
    var token = Lexer('public').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'readonly' utf16 test", () {
    var token = Lexer('readonly').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'return' utf16 test", () {
    var token = Lexer('return').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'sbyte' utf16 test", () {
    var token = Lexer('sbyte').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'short' utf16 test", () {
    var token = Lexer('short').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'static' utf16 test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'string' utf16 test", () {
    var token = Lexer('string').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'switch' utf16 test", () {
    var token = Lexer('switch').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'this' utf16 test", () {
    var token = Lexer('this').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'true' utf16 test", () {
    var token = Lexer('true').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'typeof' utf16 test", () {
    var token = Lexer('typeof').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'uint' utf16 test", () {
    var token = Lexer('uint').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'ulong' utf16 test", () {
    var token = Lexer('ulong').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'ushort' utf16 test", () {
    var token = Lexer('ushort').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'void' utf16 test", () {
    var token = Lexer('void').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'while' utf16 test", () {
    var token = Lexer('while').nextToken();
    expect(TokenType.keyword, token.type);
  });
  //end keyword tests
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
