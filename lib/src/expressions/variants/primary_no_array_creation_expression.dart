import '../primary_expression.dart';

enum PrimaryNoArrayCreationExpressionType {
  literal,
  interpolated_string_expression,
  simple_name,
  parenthesized_expression,
  member_access,
  invocation_expression,
  element_access,
  this_access,
  base_access,
  post_increment_expression,
  post_decrement_expression,
  object_creation_expression,
  delegate_creation_expression,
  anonymous_object_creation_expression,
  typeof_expression,
  checked_expression,
  unchecked_expression,
  default_value_expression,
  nameof_expression,
  anonymous_method_expression,
  primary_no_array_creation_expression_unsafe
}

class PrimaryNoArrayCreationExpression implements PrimaryExpression {
  PrimaryNoArrayCreationExpression(
    this._value,
  ) : super();

  static final PrimaryExpressionType _type =
      PrimaryExpressionType.primary_no_array_creation_expression;
  final List _value;

  @override
  PrimaryExpressionType get type {
    assert(_type == PrimaryExpressionType.primary_no_array_creation_expression);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(PrimaryExpression token) {
    return token.type == PrimaryExpressionType.primary_no_array_creation_expression;
  }
}
