import '../interface.dart';

class InterfaceModifier implements InterfaceAST{

  InterfaceModifier(this._value);
  List _value;

  List get value {
    return _value;
  }

  InterfaceKind get type{
    return _type;
  }
  static final InterfaceKind _type = InterfaceKind.interfaceModifier;


}