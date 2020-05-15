import '../constant_declaration.dart';
// import '../../statement.dart';

enum ConstantDeclaratorTypes {
  constant_declarators,
}

class ConstantDeclarator implements ConstantDeclaration {

  ConstantDeclarator(
    this._value,
  ): super();

  static final ConstantDeclarationTypes _type = ConstantDeclarationTypes.constant_declaration;
  final List _value;

  @override
  Object get type {
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == DeclarationStatementType.constant_declaration;
 // }

}
