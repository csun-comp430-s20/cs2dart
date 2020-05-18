enum NamespaceKind {
  CompilationUnit,
  NamespaceMemberDeclaration,
  TypeDeclaration,
}

class Namespace {
  Namespace(this._value);

  List _value;
  

  List get value {
    return _value;
  }

 
}
