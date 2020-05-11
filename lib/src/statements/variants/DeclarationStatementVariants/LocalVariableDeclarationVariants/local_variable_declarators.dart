import '../local_variable_declaration.dart';
import '../../../statement.dart';

enum LocalVariableDeclaratorsTypes {
  local_variable_declarator,
}

class LocalVariableDeclarators implements LocalVariableDeclaration {

  LocalVariableDeclarators(
    this._value,
  ): super();

  static final LocalVariableDeclarationTypes _type = LocalVariableDeclarationTypes.local_variable_declarators;
  final String _value;

  @override
  Object get type {
    assert(_type == LocalVariableDeclarationTypes.local_variable_declarators);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == LocalVariableDeclarationTypes.local_variable_declarators;
  }
}
