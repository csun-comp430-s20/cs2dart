import '../expression.dart';

class PlusExp implements Exp{
  final Exp _left;
  final Exp _right;

  PlusExp(this._left,this._right);

  Exp get left {
    return _left;
  }

  Exp get right {
    return _right;
  }
}
