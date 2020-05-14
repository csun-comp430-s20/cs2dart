import '../interface.dart';

class InterfaceBody implements InterfaceAST{

  InterfaceBody(this._value);
  List _value;

  List get value {
    return _value;
  }

  InterfaceKind get type{
    return _type;
  }
  static final InterfaceKind _type = InterfaceKind.interfaceBody;


}