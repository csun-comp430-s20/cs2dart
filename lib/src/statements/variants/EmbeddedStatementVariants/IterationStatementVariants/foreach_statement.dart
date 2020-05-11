import '../iteration_statement.dart';
import '../../../statement.dart';

class ForEachStatement implements Statement{

  ForEachStatement(
    this._value,
  ): super();

  static final IterationStatementType _type = IterationStatementType.foreach_statement;
  final String _value;

  @override
  IterationStatementType get type {
    assert(_type == IterationStatementType.foreach_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(IterationStatementType token){
   return token.type == IterationStatementType.foreach_statement;
 }
}
