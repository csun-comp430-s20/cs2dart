import '../switch_block.dart';
import '../../../../../statement.dart';

enum SwitchSectionType {
  switch_label,
}

class SwitchSection implements SwitchBlock{

  SwitchSection(
    this._value,
  ): super();

  static final SwitchBlockType _type = SwitchBlockType.switch_section;
  final List _value;

  @override
  Object get type {
    assert(_type == SwitchBlockType.switch_section);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(Statement token){
   return token.type == SwitchBlockType.switch_section;
 }
}
