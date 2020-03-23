import 'package:cs2dart/src/parser/Exp.dart';
class SubExp implements Exp{
  final Exp _left;
  final Exp _right;

  SubExp(this._left,this._right);
}