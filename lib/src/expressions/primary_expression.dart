enum PrimaryExpressionType {
  primary_no_array_creation_expression,
  array_creation_expression
}

abstract class PrimaryExpression {
  PrimaryExpression(
    this._value,
  );

  final List _value;



  List get value {
    return _value;
  }


}
