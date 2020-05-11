import '../selection_statement.dart';
import '../../../statement.dart';

class SwitchStatement implements Statement{

  SwitchStatement(
    this._value,
  ): super();

  static final SelectionStatementType _type = SelectionStatementType.switch_statement;
  final String _value;

  @override
  Statementype get type {
    assert(_type == Statementype.switch_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.switch_statement;
 }
}
