import '../statement.dart';
enum DeclarationStatementType {
  local_variable_declaration,
  local_constant_declaration,
}

abstract class DeclarationStatement implements Statement {

  DeclarationStatement(
    this._value,
  ): super();


  static final Statementype _type = Statementype.declaration_statement;
  final String _value;

  @override
  Object get type {
    assert(_type == Statementype.declaration_statement);
    return _type;
  }

  @override
  String get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == Statementype.declaration_statement;
 }

}
