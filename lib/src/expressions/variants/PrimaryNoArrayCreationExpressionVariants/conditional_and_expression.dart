import '../primary_no_array_creation_expression.dart';
import '../../primary_expression.dart';



class ConditionalAndExpression implements PrimaryNoArrayCreationExpression {
  ConditionalAndExpression(
    this._value,
  ) : super();

  static final PrimaryNoArrayCreationExpressionType _type =
      PrimaryNoArrayCreationExpressionType.conditional_and_expression;
  final List _value;

  @override
  PrimaryNoArrayCreationExpressionType get type {
    assert(_type == PrimaryNoArrayCreationExpressionType.conditional_and_expression);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  // @override
  // bool equals(PrimaryExpression token) {
  //   return token.type == PrimaryNoArrayCreationExpressionType.anonymous_method_expression;
  // }
}