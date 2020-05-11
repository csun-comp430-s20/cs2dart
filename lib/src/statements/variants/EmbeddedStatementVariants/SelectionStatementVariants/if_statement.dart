import '../selection_statement.dart';
import '../../../statement.dart';

class IfStatement implements SelectionStatement{

  IfStatement(
    this._value,
  ): super();

  static final SelectionStatementType _type = SelectionStatementType.if_statement;
  final List _value;

  @override
  SelectionStatementType get type {
    assert(_type == SelectionStatementType.if_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == SelectionStatementType.if_statement;
 }
}
