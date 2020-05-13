import '../statement.dart';
enum EmbeddedStatementType {
  block,
  empty_statement,
  expression_statement,
  selection_statement,
  iteration_statement,
  jump_statement,
}

class EmbeddedStatement implements Statement {

  EmbeddedStatement(
    this._value,
  ): super();


  static final Statementype _type = Statementype.embedded_statement;
  final List _value;

  @override
  Object get type {
    assert(_type == Statementype.embedded_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.embedded_statement;
 }

}
