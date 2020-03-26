import '../expression.dart';

class VariableExp implements Exp {
  final String _name;

  VariableExp(this._name);

  String get name {
    return _name;
  }
}
