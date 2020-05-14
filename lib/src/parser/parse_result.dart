import 'package:cs2dart/tokens.dart';

class ParseResult<A> {
  final TokenType _type;
  final String _value;
  ParseResult<A> leftChild;
  ParseResult<A> rightChild;
  ParseResult(this._type, this._value, this.leftChild, this.rightChild);

}
