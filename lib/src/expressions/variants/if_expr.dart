import '../expression.dart';

class IfExp implements Exp {
  final Exp _guard;
  final Exp _trueBranch;
  final Exp _falseBranch;

  IfExp(this._guard, this._trueBranch, this._falseBranch);

  Exp get guard {
    return _guard;
  }

  Exp get trueBranch {
    return _trueBranch;
  }

  Exp get falseBranch {
    return _falseBranch;
  }
}
