import '../local_variable_declarator.dart';
import '../../../../../statement.dart';

class LocalVariableInitializer implements LocalVariableDeclarator {

  LocalVariableInitializer(
    this._value,
  ): super();

  static final LocalVariableDeclaratorTypes _type = LocalVariableDeclaratorTypes.local_variable_initializer;
  final List _value;

  @override
  LocalVariableDeclaratorTypes get type {
    assert(_type == LocalVariableDeclaratorTypes.local_variable_initializer);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == LocalVariableDeclaratorTypes.local_variable_initializer;
  }
}
