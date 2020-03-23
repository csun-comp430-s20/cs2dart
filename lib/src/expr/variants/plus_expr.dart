import '../expr.dart';

class PlusExp implements Exp{
  final Exp _left;
  final Exp _right;

  PlusExp(this._left,this._right);
}
