import '../embedded_statement.dart';
import '../../statement.dart';
enum ExpressionStatementType {
  statement_expression,
}

class ExpressionStatement implements EmbeddedStatement{

  ExpressionStatement(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.expression_statement;
  final String _value;

  @override
  Object get type {
    assert(_type == EmbeddedStatementType.expression_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == EmbeddedStatementType.expression_statement;
 }
}
