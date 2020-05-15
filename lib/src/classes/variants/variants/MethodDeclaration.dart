import '../ClassBody.dart';
import '../../classAST.dart';

enum MethodKind{
  fixedParam
}
class MethodDeclaration implements ClassAST{
  MethodDeclaration(this._value);
  List _value;

  List get value {
    return _value;
  }

  ClassBodyKind get type{
    return _type;
  }
  static final ClassBodyKind _type = ClassBodyKind.methodDeclaration;
}