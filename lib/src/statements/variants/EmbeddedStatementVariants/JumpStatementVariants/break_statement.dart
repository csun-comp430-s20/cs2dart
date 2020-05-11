import '../jump_statement.dart';
import '../../../statement.dart';

class BreakStatement implements Statement{

  BreakStatement(
    this._value,
  ): super();

  static final JumpStatementType _type = JumpStatementType.break_statement;
  final String _value;

  @override
  JumpStatementType get type {
    assert(_type == JumpStatementType.break_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(JumpStatementType token){
   return token.type == JumpStatementType.break_statement;
 }
}
