import '../jump_statement.dart';
// import '../../../statement.dart';

class ContinueStatement implements JumpStatement{

  ContinueStatement(
    this._value,
  ): super();

  static final JumpStatementType _type = JumpStatementType.continue_statement;
  final List _value;

  @override
  JumpStatementType get type {
    assert(_type == JumpStatementType.continue_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == JumpStatementType.continue_statement;
 // }
}
