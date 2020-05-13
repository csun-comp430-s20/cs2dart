import '../declaration_statement.dart';
import '../../statement.dart';

enum LocalVariableDeclarationTypes {
  local_variable_declarators,
  local_variable_type,
}

class LocalVariableDeclaration implements DeclarationStatement {

  LocalVariableDeclaration(
    this._value,
  ): super();

  static final DeclarationStatementType _type = DeclarationStatementType.local_variable_declaration;
  final List _value;

  @override
  Object get type {
    assert(_type == DeclarationStatementType.local_variable_declaration);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == DeclarationStatementType.local_variable_declaration;
 }

}
