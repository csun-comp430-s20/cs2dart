import '../embedded_statement.dart';
import '../../statement.dart';
enum SelectionStatementType {
  if_statement,
  switch_statement,
}

class SelectionStatement implements Statement{

    SelectionStatement(
      this._value,
    ): super();

    static final EmbeddedStatementType _type = EmbeddedStatementType.block;
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
