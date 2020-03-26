enum NamespaceKind {
  CompilationUnit,
  NamespaceMemberDeclaration,
  TypeDeclaration,
}

abstract class Namespace {
  Namespace(this._value, this._kind);

  final String _value;
  final NamespaceKind _kind;

  String get value {
    return _value;
  }

  NamespaceKind get kind {
    return _kind;
  }
}
