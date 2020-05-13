import '../expression.dart';

class IntegerExp implements Exp{
  final int _value;

  IntegerExp(this._value);

  int get value {
    return _value;
  }
}
