import 'parser_node.dart';
import 'dart:io';
import '../tokens/token.dart';

 enum ASTKind {
  block,

}

class AST2{
 final  Token _head;
 //final Token _value;

 List _children;
 AST2(this._head);

 Token get head {
    return _head;
  }

  List get children {
    return _children;
  }


}