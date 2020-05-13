enum PrimaryExpressionType {
  primary_no_array_creation_expression,
  array_creation_expression
}

abstract class PrimaryExpression {
  PrimaryExpression(
    this._type,
    this._value,
  );

  final PrimaryExpressionType _type;
  final List _value;

  Object get type {
    return _type;
  }

  List get value {
    return _value;
  }

  bool equals(PrimaryExpression primaryExpression) {
    return _type == primaryExpression.type;
  }
}
