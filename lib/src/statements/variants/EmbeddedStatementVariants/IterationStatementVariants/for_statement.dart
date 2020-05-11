import '../iteration_statement.dart';
import '../../../statement.dart';
// enum ForStatementType {
//   for_initializer,
//   for_condition,
//   for_iterator,
// }
class ForStatement implements IterationStatement{

  ForStatement(
    this._value,
  ): super();

  static final IterationStatementType _type = IterationStatementType.for_statement;
  final String _value;

  @override
  IterationStatementType get type {
    assert(_type == IterationStatementType.for_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == IterationStatementType.for_statement;
 }
}
