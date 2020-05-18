import 'dart:math';

import 'package:cs2dart/parser.dart';
import 'package:cs2dart/lexer.dart';

import 'package:test/test.dart';


 



void main() {
//type tests
test('integral type test', () {
    var token = Lexer('int').lexify();
    
    expect('int', Parser(token).parseType().value[0].value[0].value);
    expect('ValueType', Parser(token).parseType().runtimeType.toString());
    expect('IntegralType', Parser(token).parseType().value[0].runtimeType.toString());
    

  });
  
  test('reference type test', () {
    var token = Lexer('string').lexify();
    
    expect('string', Parser(token).parseType().value[0].value);
    expect('ReferenceType', Parser(token).parseType().runtimeType.toString());

  });

  test('floating point type test', () {
    var token = Lexer('float').lexify();
    
    expect('float', Parser(token).parseType().value[0].value[0].value);
    expect('ValueType', Parser(token).parseType().runtimeType.toString());
    expect('FloatingPointType', Parser(token).parseType().value[0].runtimeType.toString());


  });

  test('bool type test', () {
    var token = Lexer('bool').lexify();
    
    expect('bool', Parser(token).parseType().value[0].value);
    expect('ValueType', Parser(token).parseType().runtimeType.toString());

  });

  test('decimal type test', () {
    var token = Lexer('decimal').lexify();
    
    expect('decimal', Parser(token).parseType().value[0].value);
    expect('ValueType', Parser(token).parseType().runtimeType.toString());
  });

  test('object type test', () {
    var token = Lexer('object').lexify();
    
    expect('object', Parser(token).parseType().value[0].value);
    expect('ReferenceType', Parser(token).parseType().runtimeType.toString());
  });

 

  test('identifier type test', () {
    var token = Lexer('thing').lexify();
    
    expect('thing', Parser(token).parseType().value[0].value);
    expect('ReferenceType', Parser(token).parseType().runtimeType.toString());
  });

  test('type returns null test', () {
    var token = Lexer('class').lexify();
    
    expect(null, Parser(token).parseType());

  });
//statement tests
 test('Empty Statement test', () {
    var token = Lexer(';').lexify();
    var parseResult = Parser(token).parseStatements();

    expect(';', parseResult.value[0].value);
    expect('EmptyStatement', parseResult.runtimeType.toString());
  });

  test('empty Block Statement test', () {
    var token = Lexer('{}').lexify();
    var parseResult = Parser(token).parseStatements();

    expect('{', parseResult.value[0].value);
    expect('}', parseResult.value[1].value);
    expect('Block' , parseResult.runtimeType.toString());

  });

  test('Block Statement with internal statment test', () {
    var token = Lexer('{;}').lexify();
    var parseResult = Parser(token).parseStatements();

    expect('{', parseResult.value[0].value);
    expect('EmptyStatement', parseResult.value[1].runtimeType.toString());
    expect(';', parseResult.value[1].value[0].value);
    expect('}', parseResult.value[2].value);
    expect('Block' , parseResult.runtimeType.toString());

  });

  test('Block Statement with multiple internal statments test', () {
    var token = Lexer('{;;}').lexify();
    var parseResult = Parser(token).parseStatements();

    expect('{', parseResult.value[0].value);
    expect('EmptyStatement', parseResult.value[1].runtimeType.toString());
    expect(';', parseResult.value[1].value[0].value);
    expect('EmptyStatement', parseResult.value[2].runtimeType.toString());
    expect(';', parseResult.value[2].value[0].value);
    expect('}', parseResult.value[3].value);
    expect('Block' , parseResult.runtimeType.toString());

  });

  test('Local Variable Declaration test', () {
    var token = Lexer('int x;').lexify();
    var parseResult = Parser(token).parseStatements();

    expect('DeclarationStatement', parseResult.runtimeType.toString());
    expect('LocalVariableDeclaration', parseResult.value[0].runtimeType.toString());
    expect('LocalVariableType', parseResult.value[0].value[0].runtimeType.toString());
    expect('LocalVariableDeclarator', parseResult.value[0].value[1].runtimeType.toString());
    expect(parseResult.value[0].value[0].value[0].runtimeType.toString(), 'ValueType');
    expect(parseResult.value[0].value[1].value[0].runtimeType.toString(), 'IdentifierToken');
    expect(parseResult.value[0].value[0].value[0].value[0].runtimeType.toString(), 'IntegralType');
    expect(parseResult.value[0].value[0].value[0].value[0].value[0].runtimeType.toString(),'KeywordToken');
  });

  test('Local Variable Declaration with assignment test', () {
    var token = Lexer('int x = 3;').lexify();
    var parseResult = Parser(token).parseStatements();

    
    expect('DeclarationStatement', parseResult.runtimeType.toString());
    expect('LocalVariableDeclaration', parseResult.value[0].runtimeType.toString());
    expect('LocalVariableType', parseResult.value[0].value[0].runtimeType.toString());
    expect('LocalVariableDeclarator', parseResult.value[0].value[1].runtimeType.toString());
    expect(parseResult.value[0].value[0].value[0].runtimeType.toString(), 'ValueType');
    expect(parseResult.value[0].value[0].value[0].value[0].runtimeType.toString(), 'IntegralType');
    expect(parseResult.value[0].value[0].value[0].value[0].value[0].runtimeType.toString(),'KeywordToken');
    expect(parseResult.value[0].value[1].value[0].runtimeType.toString(), 'IdentifierToken');
    expect(parseResult.value[0].value[1].value[1].runtimeType.toString(), 'OperatorOrPunctuatorToken');
    expect(parseResult.value[0].value[1].value[2].runtimeType.toString(), 'LocalVariableInitializer');
    expect(parseResult.value[0].value[1].value[2].value[0].runtimeType.toString(), 'PrimaryNoArrayCreationExpression');
    expect(parseResult.value[0].value[1].value[2].value[0].value[0].runtimeType.toString(), 'IntegerLiteralToken');




    
  });

  test('Const Variable Declaration test', () {
    var token = Lexer('const int x;').lexify();
    var parseResult = Parser(token).parseStatements();
    
    expect('DeclarationStatement', parseResult.runtimeType.toString());
    expect('ConstantDeclaration', parseResult.value[0].runtimeType.toString());
    expect('KeywordToken', parseResult.value[0].value[0].runtimeType.toString());
    expect('ValueType', parseResult.value[0].value[1].runtimeType.toString());
    expect('IdentifierToken', parseResult.value[0].value[2].runtimeType.toString());

  });

   test('Const Variable with assignment Declaration test', () {
    var token = Lexer('const string x = "test";').lexify();
    var parseResult = Parser(token).parseStatements();
    
    expect('DeclarationStatement', parseResult.runtimeType.toString());
    expect('ConstantDeclaration', parseResult.value[0].runtimeType.toString());
    expect('KeywordToken', parseResult.value[0].value[0].runtimeType.toString());
    expect('ReferenceType', parseResult.value[0].value[1].runtimeType.toString());
    expect('IdentifierToken', parseResult.value[0].value[2].runtimeType.toString());
  });

  test('For Loop Test', () {
    var token = Lexer('for(int i=0;i<5;i=i+1){;}').lexify();
    var parseResult = Parser(token).parseStatements();
    
    print(parseResult.runtimeType.toString());
    
  });

  test('Block with 2 statements test ', () {
    var token = Lexer('{int x; int y;}').lexify();
    var parseResult = Parser(token).parseBlockStatement();

    print(parseResult.value[2].runtimeType.toString());

    expect(parseResult.runtimeType.toString(), 'Block');
  });

    test('Method with Block with 2 statements test ', () {
      var token = Lexer('int Main(){int x; bool y = false;}').lexify();
      var parseResult = Parser(token).parseMethodDeclaration();

      print(parseResult.value[4].runtimeType.toString());
      print(parseResult.value[4].value[1].runtimeType.toString());
      print(parseResult.value[4].value[2].runtimeType.toString());

      expect(parseResult.runtimeType.toString(), 'MethodDeclaration');
    });
  //expression tests

  //class tests
  test('empty class Test', () {
    var token = Lexer('class someClass{}').lexify();
    var parseResult = Parser(token).parseClass();
    print(parseResult.runtimeType.toString());

    expect(parseResult.runtimeType.toString(),"ClassDeclaration");
  });

  test('class with variable declaration test', (){
    var token = Lexer('class someClass{int x = 1;}').lexify();
    var parseResult = Parser(token).parseClass();

    expect(parseResult.runtimeType.toString(),"ClassDeclaration");
  });

  test('class with const variable declaration test', (){
    var token = Lexer('class someClass{const int x = 1;}').lexify();
    var parseResult = Parser(token).parseClass();

    expect(parseResult.runtimeType.toString(),"ClassDeclaration");
  });

  test('class with method declaration test', (){
    var token = Lexer('class someClass{int method(){}}').lexify();
    var parseResult = Parser(token).parseClass();

    expect(parseResult.runtimeType.toString(),"ClassDeclaration");
  });

test('method parse test', (){
  var token = Lexer('int method(){}').lexify();
  var parseResult = Parser(token).parseMethodDeclaration();
  expect(parseResult.runtimeType.toString(),"MethodDeclaration");
});
  test('class with Constructor declaration test', (){
    var token = Lexer('class someClass{SomeClass(){}}').lexify();
    var parseResult = Parser(token).parseClass();

    expect(parseResult.runtimeType.toString(),"ClassDeclaration");
  });

   
}
