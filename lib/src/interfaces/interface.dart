enum InterfaceKind{
  interfaceDeclaration,
  interfaceModifier,
  interfaceBase,
  interfaceBody
}
class InterfaceAST{

  InterfaceAST(this._value);

  List _value;

  List get value {
    return _value;
  }


}