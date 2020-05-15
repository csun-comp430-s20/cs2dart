import '../MethodDeclaration.dart';
import '../../../classAST.dart';
import '../MethodDeclaration.dart';

class FixedParam implements ClassAST{
 FixedParam(this._value);
  List _value;

  List get value {
    return _value;
  }

  MethodKind get type{
    return _type;
  }
  static final MethodKind _type = MethodKind.fixedParam;
}