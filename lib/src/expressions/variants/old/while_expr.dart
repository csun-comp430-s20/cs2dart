import '../expression.dart';

class WhileExp implements Exp {
  final Exp _cond;
  final Exp _block;

  WhileExp(this._cond, this._block);

  Exp get cond {
    return _cond;
  }

  Exp get block {
    return _block;
  }
}
