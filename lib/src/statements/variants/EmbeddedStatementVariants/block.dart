import '../embedded_statement.dart';
import '../../statement.dart';
class Block implements EmbeddedStatement{

  Block(
    this._value,
  ): super();

  static final EmbeddedStatementType _type = EmbeddedStatementType.block;
  final List _value;

  @override
  EmbeddedStatementType get type {
    assert(_type == EmbeddedStatementType.block);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == EmbeddedStatementType.block;
 }
}
