import '../parser_ast2.dart';
import '../parser_node.dart';
import '../../tokens/token.dart';

class BlockAST implements AST2 {

  final Token _head;
  List _children;
  static final ASTKind _type = ASTKind.block;
  
  BlockAST(
    this._head,
  ): super();



  @override
  ASTKind get type {
    assert(_type == ASTKind.block);
    return _type;
  }

  @override
  List get children {
    return _children;
  }

  @override
  Token get head{
    return _head;
  }

  
}