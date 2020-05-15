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
    expect(';', Parser(token).parseStatements().value[0].value);
    expect('EmptyStatement', Parser(token).parseStatements().runtimeType.toString());
  });

  test('empty Block Statement test', () {
    var token = Lexer('{}').lexify();
    expect('{', Parser(token).parseStatements().value[0].value);
    expect('}', Parser(token).parseStatements().value[1].value);
    expect('Block' , Parser(token).parseStatements().runtimeType.toString());

  });

  test('Block Statement with internal statment test', () {
    var token = Lexer('{;}').lexify();
    expect('{', Parser(token).parseStatements().value[0].value);
    expect('EmptyStatement', Parser(token).parseStatements().value[1].runtimeType.toString());
    expect(';', Parser(token).parseStatements().value[1].value[0].value);
    expect('}', Parser(token).parseStatements().value[2].value);
    expect('Block' , Parser(token).parseStatements().runtimeType.toString());

  });

  test('Block Statement with multiple internal statments test', () {
    var token = Lexer('{;;}').lexify();
    expect('{', Parser(token).parseStatements().value[0].value);
    expect('EmptyStatement', Parser(token).parseStatements().value[1].runtimeType.toString());
    expect(';', Parser(token).parseStatements().value[1].value[0].value);
    expect('EmptyStatement', Parser(token).parseStatements().value[2].runtimeType.toString());
    expect(';', Parser(token).parseStatements().value[2].value[0].value);
    expect('}', Parser(token).parseStatements().value[3].value);
    expect('Block' , Parser(token).parseStatements().runtimeType.toString());

  });

  test('Local Variable Declaration test', () {
    var token = Lexer('int x;').lexify();
    
    print(Parser(token).parseStatements().runtimeType.toString());

  });

  //expression tests

  //class tests

  
   
}
