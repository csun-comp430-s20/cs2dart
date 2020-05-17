import '../interface.dart';

class InterfaceDeclaration implements InterfaceAST {

  InterfaceDeclaration(this._value);
  List _value;

  List get value {
    return _value;
  }

  InterfaceKind get type{
    return _type;
  }
  static final InterfaceKind _type = InterfaceKind.interfaceDeclaration;


}