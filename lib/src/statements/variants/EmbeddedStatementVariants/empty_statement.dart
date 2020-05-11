import '../embedded_statement.dart';
import '../../statement.dart';
class EmptyStatement implements EmbeddedStatement{

  EmptyStatement(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.empty_statement;
  final String _value;

  @override
  EmbeddedStatementType get type {
    assert(_type == EmbeddedStatementType.empty_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == EmbeddedStatementType.empty_statement;
 }
}
