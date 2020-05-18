import '../embedded_statement.dart';
// import '../../statement.dart';
enum JumpStatementType {
  break_statement,
  continue_statement,
  return_statement,
}

class JumpStatement implements EmbeddedStatement{

  JumpStatement(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.jump_statement;
  final List _value;

  @override
  Object get type {
    assert(_type == EmbeddedStatementType.jump_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == EmbeddedStatementType.jump_statement;
 // }
}
