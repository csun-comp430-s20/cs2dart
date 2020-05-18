import 'package:cs2dart/parser.dart';
import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/code_generator.dart';

import 'package:test/test.dart';

void main() {
//type tests
    // test('Method with Block with 2 statements test ', () {
    //   var token = Lexer('int Main(){int x = 0; bool y = false;}').lexify();
    //   var parseResult = Parser(token).parseMethodDeclaration();
    //
    //   print(parseResult.value[4].runtimeType.toString());
    //   print(parseResult.value[4].value[1].runtimeType.toString());
    //   print(parseResult.value[4].value[2].runtimeType.toString());
    //
    //   expect(parseResult.runtimeType.toString(), 'MethodDeclaration');
    // });
    // test('Method with Block with 2 statements test PART 2', () {
    //   var token = Lexer('int Main(){int x; bool y;}').lexify();
    //   var parseResult = Parser(token).parseMethodDeclaration();
    //
    //   print(parseResult.value[4].runtimeType.toString());
    //   print(parseResult.value[4].value[1].runtimeType.toString());
    //   print(parseResult.value[4].value[2].runtimeType.toString());
    //
    //   expect(parseResult.runtimeType.toString(), 'MethodDeclaration');
    // });
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

  //Something wrong with the parser..

  // test('method code test with parameters', () {
  //   var listOfTokens  = Lexer('class Program {void Main(int a){}}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main( int a ){ } } ', cg.genCode());
  // });

  // //=========================================================================================================

  // //Statements

  // test('test empty statement', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){;}}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){; } } ', cg.genCode());
  // });

  test('test variable declaration statement', () {
    var listOfTokens  = Lexer('class Program {void Main(){string name = "Chad";}}').lexify();
    var parser = Parser(listOfTokens);
    var outputParse = parser.parse();
    var cg = ClassGenerator(outputParse);
    // print('===============Debugcomment=============10');
    expect('class Program { void Main(){ String  name = "Chad";  } } ', cg.genCode());
  });

  //Parseing error

  // test('test if statement', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){int num = 10; num = 5 + num; }}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){int num = 10; num = 5 + num; } } ', cg.genCode());
  // });

  // test('statment code test', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){string name = "Chad"; int num = 10; }}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){string name = "Chad"; int num = 10; } } ', cg.genCode());
  // });

  // test('test int variable ', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){int num = 10; num = 5 + num; }}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){int num = 10; num = 5 + num; } } ', cg.genCode());
  // });
  // test('test bool variable declaration', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){bool result = true;}}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){bool result = true; } } ', cg.genCode());
  // });
  // test('test string variable declaration', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){string name = "Chad";}}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){int num = 10; num = 5 + num; } } ', cg.genCode());
  // });

  // test('expression code test bool', () {
  //   var listOfTokens  = Lexer('class Program {void Main(){string name = "Chad";}}').lexify();
  //   var parser = Parser(listOfTokens);
  //   var outputParse = parser.parse();
  //   var cg = ClassGenerator(outputParse);
  //   // print('===============Debugcomment=============10');
  //   expect('class Program { void Main(){int num = 10; num = 5 + num; } } ', cg.genCode());
  // });


}
