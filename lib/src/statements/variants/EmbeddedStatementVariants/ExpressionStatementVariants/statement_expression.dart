import '../expression_statement.dart';
import '../../../statement.dart';

enum StatementExpressionType {
  invocation_expression,
  null_conditional_invocation_expression,
  object_creation_expression,
  assignment,
  post_increment_expression,
  post_decrement_expression,
  pre_increment_expression,
  pre_decrement_expression,
  await_expression,
}

class StatementExpression implements Statement{

  StatementExpression(
    this._value,
  ): super();

  static final ExpressionStatementType _type = ExpressionStatementType.statement_expression;
  final String _value;

  @override
  ExpressionStatementType get type {
    assert(_type == ExpressionStatementType.statement_expression);
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
