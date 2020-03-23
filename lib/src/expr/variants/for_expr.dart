import '../expr.dart';

class ForExp implements Exp {
  final Exp _init;
  final Exp _cond;
  final Exp _incr;
  final Exp _block;

  ForExp(this._init, this._cond, this._incr, this._block);
}
