import '../jump_statement.dart';
// import '../../../statement.dart';

class BreakStatement implements JumpStatement{

  BreakStatement(
    this._value,
  ): super();

  static final JumpStatementType _type = JumpStatementType.break_statement;
  final List _value;

  @override
  JumpStatementType get type {
    assert(_type == JumpStatementType.break_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == JumpStatementType.break_statement;
 // }
}
