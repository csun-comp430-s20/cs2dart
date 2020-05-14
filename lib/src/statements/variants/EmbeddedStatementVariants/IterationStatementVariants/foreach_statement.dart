import '../iteration_statement.dart';
// import '../../../statement.dart';

class ForEachStatement implements IterationStatement{

  ForEachStatement(
    this._value,
  ): super();

  static final IterationStatementType _type = IterationStatementType.foreach_statement;
  final List _value;

  @override
  IterationStatementType get type {
    assert(_type == IterationStatementType.foreach_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == IterationStatementType.foreach_statement;
 // }
}
