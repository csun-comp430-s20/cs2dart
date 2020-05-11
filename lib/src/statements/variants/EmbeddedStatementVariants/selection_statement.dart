import '../embedded_statement.dart';
import '../../statement.dart';
enum SelectionStatementType {
  if_statement,
  switch_statement,
}

class SelectionStatement implements EmbeddedStatement{

    SelectionStatement(
      this._value,
    ): super();

    static final EmbeddedStatementType _type = EmbeddedStatementType.selection_statement;
    final String _value;

    @override
    Object get type {
      assert(_type == EmbeddedStatementType.selection_statement);
      return _type;
    }

    @override
    String get value {
      return _value;
    }

    @override
    bool equals(Statement token){
     return token.type == EmbeddedStatementType.selection_statement;
   }
  }
