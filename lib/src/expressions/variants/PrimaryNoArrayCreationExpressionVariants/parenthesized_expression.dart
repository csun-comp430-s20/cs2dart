import '../primary_no_array_creation_expression.dart';
import '../../primary_expression.dart';



class ParenthesizedExpression implements PrimaryNoArrayCreationExpression {
  ParenthesizedExpression(
    this._value,
  ) : super();

  static final PrimaryNoArrayCreationExpressionType _type =
      PrimaryNoArrayCreationExpressionType.parenthesized_expression;
  final List _value;

  @override
  PrimaryNoArrayCreationExpressionType get type {
    assert(_type == PrimaryNoArrayCreationExpressionType.parenthesized_expression);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(PrimaryExpression token) {
    return token.type == PrimaryNoArrayCreationExpressionType.parenthesized_expression;
  }
}