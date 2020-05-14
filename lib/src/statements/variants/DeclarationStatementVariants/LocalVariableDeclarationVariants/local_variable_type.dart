import '../local_variable_declaration.dart';
// import '../../../statement.dart';

class LocalVariableType implements LocalVariableDeclaration {

  LocalVariableType(
    this._value,
  ): super();

  static final LocalVariableDeclarationTypes _type = LocalVariableDeclarationTypes.local_variable_type;
  final List _value;

  @override
  LocalVariableDeclarationTypes get type {
    assert(_type == LocalVariableDeclarationTypes.local_variable_type);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  // @override
  // bool equals(Statement token){
  //  return token.type == LocalVariableDeclarationTypes.local_variable_type;
  // }
}
