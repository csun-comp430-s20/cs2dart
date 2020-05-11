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


  static final Statementype _type = Statementype.labeled_statement;
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
