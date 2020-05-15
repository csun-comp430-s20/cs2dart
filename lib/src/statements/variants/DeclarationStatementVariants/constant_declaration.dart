import '../declaration_statement.dart';
// import '../../statement.dart';

// enum ConstantDeclarationTypes {
//   constant_declarator,
// }

class ConstantDeclaration implements DeclarationStatement {

  ConstantDeclaration(
    this._value,
  ): super();

  static final DeclarationStatementType _type = DeclarationStatementType.constant_declaration;
  final List _value;

  @override
  Object get type {
    assert(_type == DeclarationStatementType.constant_declaration);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == DeclarationStatementType.local_constant_declaration;
 // }

}
