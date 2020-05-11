import '../embedded_statement.dart';
import '../../statement.dart';
enum ExpressionStatementType {
  statement_expression,
}

class ExpressionStatement implements Statement{

  ExpressionStatement(
    this._value,
  ): super();

  static final Statementype _type = Statementype.embedded_statement;
  final String _value;

  @override
  Statementype get type {
    assert(_type == Statementype.embedded_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.embedded_statement;
 }
}
