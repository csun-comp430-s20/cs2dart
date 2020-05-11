import '../selection_statement.dart';
import '../../../statement.dart';

enum SwitchStatementType {
  switch_block,
}

class SwitchStatement implements SelectionStatement{

  SwitchStatement(
    this._value,
  ): super();

  static final SelectionStatementType _type = SelectionStatementType.switch_statement;
  final String _value;

  @override
  Object get type {
    assert(_type == SelectionStatementType.switch_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == SelectionStatementType.switch_statement;
 }
}
