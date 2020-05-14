import '../jump_statement.dart';
// import '../../../statement.dart';

class ReturnStatement implements JumpStatement{

  ReturnStatement(
    this._value,
  ): super();

  static final JumpStatementType _type = JumpStatementType.return_statement;
  final List _value;

  @override
  JumpStatementType get type {
    assert(_type == JumpStatementType.return_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == JumpStatementType.return_statement;
 // }
}
