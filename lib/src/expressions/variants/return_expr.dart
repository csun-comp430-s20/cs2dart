import '../expression.dart';

class ReturnExp implements Exp{
  final int _value;

  ReturnExp(this._value);

  int get value {
    return _value;
  }
}