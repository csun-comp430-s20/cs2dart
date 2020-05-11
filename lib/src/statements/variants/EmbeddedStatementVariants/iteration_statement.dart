import '../embedded_statement.dart';
import '../../statement.dart';
enum IterationStatementType {
  while_statement,
  do_statement,
  for_statement,
  foreach_statement,
}
class IterationStatement implements Statement{

  IterationStatement(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.block;
  final String _value;

  @override
  Statementype get type {
    assert(_type == Statementype.labeled_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.labeled_statement;
 }
}
