//import 'package:cs2dart/src/abstractions/abstraction.dart';

enum ClassKind{
  classDeclaration,
  classModifier,
  classBody,
  classBase
}

class ClassAST{

  ClassAST(this._value);

  List _value;

  List get value {
    return _value;
  }
}
