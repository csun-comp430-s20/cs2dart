import '../switch_statement.dart';
// import '../../../../statement.dart';

enum SwitchBlockType {
  switch_section,
}

class SwitchBlock implements SwitchStatement{

  SwitchBlock(
    this._value,
  ): super();

  static final SwitchStatementType _type = SwitchStatementType.switch_block;
  final List _value;

  @override
  Object get type {
    assert(_type == SwitchStatementType.switch_block);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == SwitchStatementType.switch_block;
 // }
}
