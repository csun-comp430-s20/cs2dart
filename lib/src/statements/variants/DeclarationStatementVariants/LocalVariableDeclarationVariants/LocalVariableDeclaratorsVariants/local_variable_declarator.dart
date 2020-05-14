import '../local_variable_declarators.dart';
// import '../../../../statement.dart';

enum LocalVariableDeclaratorTypes {
  local_variable_initializer,
}

class LocalVariableDeclarator implements LocalVariableDeclarators {

  LocalVariableDeclarator(
    this._value,
  ): super();

  static final LocalVariableDeclaratorsTypes _type = LocalVariableDeclaratorsTypes.local_variable_declarator;
  final List _value;

  @override
  Object get type {
    assert(_type == LocalVariableDeclaratorsTypes.local_variable_declarator);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  // @override
  // bool equals(Statement token){
  //  return token.type == LocalVariableDeclaratorsTypes.local_variable_declarator;
  // }
}
