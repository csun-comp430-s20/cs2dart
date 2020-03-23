import '../expr.dart';

class DivExp implements Exp {
  final Exp _left;
  final Exp _right;

  DivExp(this._left,this._right);
}
