import '../embedded_statement.dart';
import '../../statement.dart';
enum ExpressionStatementType {
  statement_expression,
}

class ExpressionStatement implements Statement{

  ExpressionStatement(
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
