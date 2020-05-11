import '../switch_statement.dart';
import '../../../../statement.dart';

class SwitchBlock implements Statement{

  SwitchBlock(
    this._value,
  ): super();

  static final SelectionStatementType _type = SelectionStatementType.if_statement;
  final String _value;

  @override
  Statementype get type {
    assert(_type == Statementype.labeled_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.labeled_statement;
 }
}
