import '../expr.dart';

class IfExp implements Exp {
  final Exp _guard;
  final Exp _trueBranch;
  final Exp _falseBranch;

  IfExp(this._guard, this._trueBranch, this._falseBranch);
}
