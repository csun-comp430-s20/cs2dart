import '../expression.dart';

class SubExp implements Exp{
  final Exp _left;
  final Exp _right;

  SubExp(this._left, this._right);

  Exp get left {
    return _left;
  }

  Exp get right {
    return _right;
  }
}
