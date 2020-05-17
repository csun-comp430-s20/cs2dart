import 'package:cs2dart/parser.dart';
import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/code_generator.dart';

import 'package:test/test.dart';

void main() {
//type tests
  test('class code test', () {
    var listOfTokens  = Lexer('class Program {}').lexify();
    var parser = Parser(listOfTokens);
    var outputParse = parser.parse();
    var cg = ClassGenerator(outputParse);
    // print('===============Debugcomment=============10');
    expect('class Program { } ', cg.genCode());
  });
  test('method code test', () {
    var listOfTokens  = Lexer('class Program {void Main(){}}').lexify();
    var parser = Parser(listOfTokens);
    var outputParse = parser.parse();
    print('===============Debugcomment=============10');
    var cg = ClassGenerator(outputParse);
    print(cg.genCode());
    expect('class Program { void Main(){ } } ', cg.genCode());
  });
  test('statment code test', () {
    var listOfTokens  = Lexer('class Program {void Main(){string name = "Chad";}}').lexify();
    var parser = Parser(listOfTokens);
    var outputParse = parser.parse();
    var cg = ClassGenerator(outputParse);
    // print('===============Debugcomment=============10');
    expect('class Program { void Main(){string name = "Chad"; int num = 10; } } ', cg.genCode());
  });
}
