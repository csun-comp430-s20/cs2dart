import 'package:cs2dart/parser.dart';
import 'package:cs2dart/lexer.dart';

import 'package:test/test.dart';

void main() {
  var line = Lexer('int y = 1+2+3;');
  var list = line.lexify();

  for (var i=0; i<list.length; i++) {
    print(i);
    print(list[i]);
    print(list[i].value);
  }

   var statementEx = AST();

  ParseNode tmpNode;
  // tmpNode = ParseNode(list[0], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[0].value} is pushed.");
  // tmpNode = ParseNode(list[1], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[1].value} is pushed.");
  // tmpNode = ParseNode(list[2], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[2].value} is pushed.");
  // tmpNode = ParseNode(list[3], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[3].value} is pushed.");
  // tmpNode = ParseNode(list[4], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[4].value} is pushed.");
  // tmpNode = ParseNode(list[5], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[5].value} is pushed.");
  // tmpNode = ParseNode(list[6], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[6].value} is pushed.");
  // tmpNode = ParseNode(list[7], null, null);
  // astTree.insert(tmpNode);
  // print("Token ${list[7].value} is pushed.");
  for (var i=0; i<list.length; i++) {
    tmpNode = ParseNode(list[i], null, null);
    statementEx.insert(tmpNode);
    print("Token ${list[i].value} is pushed.");
  }
  statementEx.printTree();
}
