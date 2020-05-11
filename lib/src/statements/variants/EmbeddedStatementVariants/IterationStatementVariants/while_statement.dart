import '../iteration_statement.dart';
import '../../../statement.dart';

class WhileStatement implements IterationStatement{

  WhileStatement(
    this._value,
  ): super();

  static final IterationStatementType _type = IterationStatementType.while_statement;
  final String _value;

  @override
  IterationStatementType get type {
    assert(_type == IterationStatementType.while_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == IterationStatementType.while_statement;
 }
}
