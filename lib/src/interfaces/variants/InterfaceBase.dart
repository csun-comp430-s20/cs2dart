import '../interface.dart';

class InterfaceBase implements InterfaceAST{

  InterfaceBase(this._value);
  List _value;

  List get value {
    return _value;
  }

  InterfaceKind get type{
    return _type;
  }
  static final InterfaceKind _type = InterfaceKind.interfaceBase;


}