import 'package:cs2dart/src/parser/Exp.dart';
class WhileExp implements Exp{
  final _cond;
  final _block;

  WhileExp(this._cond,this._block);
}