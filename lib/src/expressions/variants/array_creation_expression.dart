import '../primary_expression.dart';
class ArrayCreationExpression implements PrimaryExpression {

  ArrayCreationExpression(
    this._value,
  ): super();


  static final PrimaryExpressionType _type = PrimaryExpressionType.array_creation_expression;
  final List _value;

  @override
  PrimaryExpressionType get type {
    assert(_type == PrimaryExpressionType.array_creation_expression);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(PrimaryExpression token){
   return token.type == PrimaryExpressionType.array_creation_expression;
 }

}