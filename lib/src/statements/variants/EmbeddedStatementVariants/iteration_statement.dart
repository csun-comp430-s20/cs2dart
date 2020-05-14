import '../embedded_statement.dart';
// import '../../statement.dart';
enum IterationStatementType {
  while_statement,
  do_statement,
  for_statement,
  foreach_statement,
}
class IterationStatement implements EmbeddedStatement{

  IterationStatement(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.iteration_statement;
  final List _value;

  @override
  Object get type {
    assert(_type == EmbeddedStatementType.iteration_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == EmbeddedStatementType.iteration_statement;
 // }
}
