import 'package:cs2dart/src/parser/Exp.dart';
class MultExp implements Exp{
  final Exp _left;
  final Exp _right;

  MultExp(this._left,this._right);
}