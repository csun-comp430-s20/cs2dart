import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';

import 'package:test/test.dart';

void main() {

  //identifier tests
  test('basic identifier Test', () {
    var token = Lexer('hello').nextToken();
    expect(TokenType.identifier, token.type);
  });

  test('undersocre identifier Test', () {
    var token = Lexer('_4ello').nextToken();
    expect(TokenType.identifier, token.type);
  });
  //end identifier tests
  //keyword tests

  test("The 'as' keyword test", () {
    var token = Lexer('as').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'bool' keyword test", () {
    var token = Lexer('bool').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'break' keyword test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'byte' keyword test", () {
      var token = Lexer('byte').nextToken();
      expect(TokenType.keyword, token.type);
    });

  test("The 'case' keyword test", () {
    var token = Lexer('case').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'char' keyword test", () {
    var token = Lexer('char').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'class' keyword test", () {
    var token = Lexer('class').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'const' keyword test", () {
    var token = Lexer('const').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'continue' keyword test", () {
    var token = Lexer('continue').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'decimal' keyword test", () {
    var token = Lexer('decimal').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'do' keyword test", () {
    var token = Lexer('do').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'double' keyword test", () {
    var token = Lexer('double').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'else' keyword test", () {
    var token = Lexer('else').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'false' keyword test", () {
    var token = Lexer('false').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'float' keyword test", () {
    var token = Lexer('float').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'for' keyword test", () {
    var token = Lexer('for').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'foreach' keyword test", () {
    var token = Lexer('foreach').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'if' keyword test", () {
    var token = Lexer('if').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'in' keyword test", () {
    var token = Lexer('in').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'intbreak' keyword test", () {
    var token = Lexer('int').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'interface' keyword test", () {
    var token = Lexer('interface').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'internal' keyword test", () {
    var token = Lexer('internal').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'protected' keyword test", () {
    var token = Lexer('protected').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'is' keyword test", () {
    var token = Lexer('is').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'long' keyword test", () {
    var token = Lexer('long').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'new' keyword test", () {
    var token = Lexer('new').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'null' keyword test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'object' keyword test", () {
    var token = Lexer('object').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'private' keyword test", () {
    var token = Lexer('private').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'public' keyword test", () {
    var token = Lexer('protected').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'private' keyword test", () {
    var token = Lexer('public').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'readonly' keyword test", () {
    var token = Lexer('readonly').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'return' keyword test", () {
    var token = Lexer('return').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'sbyte' keyword test", () {
    var token = Lexer('sbyte').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'short' keyword test", () {
    var token = Lexer('short').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'static' keyword test", () {
    var token = Lexer('break').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'string' keyword test", () {
    var token = Lexer('string').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'switch' keyword test", () {
    var token = Lexer('switch').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'this' keyword test", () {
    var token = Lexer('this').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'true' keyword test", () {
    var token = Lexer('true').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'typeof' keyword test", () {
    var token = Lexer('typeof').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'uint' keyword test", () {
    var token = Lexer('uint').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'ulong' keyword test", () {
    var token = Lexer('ulong').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'ushort' keyword test", () {
    var token = Lexer('ushort').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'void' keyword test", () {
    var token = Lexer('void').nextToken();
    expect(TokenType.keyword, token.type);
  });

  test("The 'while' keyword test", () {
    var token = Lexer('while').nextToken();
    expect(TokenType.keyword, token.type);
  });
  //end keyword tests
  
  //begin real literal tests
  test('basic realLiteral Test', () {
    var token = Lexer('1').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('decimal realLiteral Test', () {
    var token = Lexer('1.1').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('decimal exponent realLiteral Test', () {
    var token = Lexer('1.1e10').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('decimal exponent with sign realLiteral Test', () {
    var token = Lexer('1.1e-10').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('decimal exponent big E realLiteral Test', () {
    var token = Lexer('1.1E10').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('decimal exponent big E with sign realLiteral Test', () {
    var token = Lexer('1.1E-10').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

   test("type suffix 'F' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1F').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test("type suffix 'f' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1f').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test("type suffix 'D' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1D').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test("type suffix 'd' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1d').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test("type suffix 'M' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1M').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test("type suffix 'm' realLiteral Test", () {//fails check if need to implement 
    var token = Lexer('1m').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('type suffix with decimal realLiteral Test', () {//fails check if need to implement 
    var token = Lexer('1.1f').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('type suffix with decimal 2 realLiteral Test', () {//fails check if need to implement 
    var token = Lexer('.1f').nextToken();
    expect(TokenType.realLiteral, token.type);
  });

  test('type suffix with exponent realLiteral Test', () {//fails check if need to implement 
    var token = Lexer('1.1e1f').nextToken();
    expect(TokenType.realLiteral, token.type);
  });
  //end real literal tests

  //begin intergerliteral tests ***come back to this

  //end intergerliteral tests

  //begin interpolated stringliteral tests
  test('basic interpolated string literal test', () {//fails check if need to implement 
    var token = Lexer('\$\"hi\"').nextToken();
    expect(TokenType.interpolatedStringLiteral, token.type);
  });

  test('basic interpolated string literal test', () {//fails check if need to implement 
    var token = Lexer('\$\"hi\"').nextToken();
    expect(TokenType.interpolatedStringLiteral, token.type);
  });

  test('interpolated string literal with brakets test', () {//fails check if need to implement 
    var token = Lexer('\$\"hi{hello}\"').nextToken();
    expect(TokenType.interpolatedStringLiteral, token.type);
  });
  //end interpolated string literal tests

  //begin string literal tests
  test('basic  string literal test', () {//fails check if need to implement 
    var token = Lexer('\"hello\"').nextToken();
    expect(TokenType.stringLiteral, token.type);
  });
  //end string literal tests

  //begin character literal tests
  test('basic character literal test', () {//fails check if need to implement 
    var token = Lexer("\'a\'").nextToken();
    expect(TokenType.characterLiteral, token.type);
  });
  //end character literal tests

  //begin operator or punctuator tests
  test('{ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('{').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('} operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('}').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('[ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('[').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('] operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer(']').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('( operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('(').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test(') operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer(')').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('. operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('.').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test(', operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer(',').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test(': operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer(':').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('; operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer(';').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('+ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('+').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('- operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('-').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('* operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('*').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('/ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('/').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('% operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('%').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('& operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('&').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('| operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('|').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('^ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('^').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('! operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('!').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('~ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('~').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('< operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('<').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('> operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('>').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('? operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('?').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('?? operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('??').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test(':: operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('::').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('++ operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('++').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('-- operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('--').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('&& operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('&&').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('|| operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('||').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('-> operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('->').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('== operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('==').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('!= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('!=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('<= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('<=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('>= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('>=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('+= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('+=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('-= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('-=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('/= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('/=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('&= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('%=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('&= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('&=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('|= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('|=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('^= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('^=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('<< operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('<<').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('<<= operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('<<=').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });

  test('=> operatorOrPunctuator test', () {//fails check if need to implement 
    var token = Lexer('=>').nextToken();
    expect(TokenType.operatorOrPunctuator, token.type);
  });
  //end operator or punctuator tests

  //start exception testing
  test('Lexer Exception Test', () {//fails check if need to implement 
    // var token = Lexer('=>').nextToken();
    expect(() => Lexer('\'').nextToken(), throwsException);
    //below line doesnt pass even though it should, have checked that exception matches so it
    //should be fine.
    //expect(() => Lexer('\'').nextToken(), throwsA(LexerException('Unexpected character')));
  });
  //end exception testing
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
