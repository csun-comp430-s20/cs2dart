import '../primary_no_array_creation_expression.dart';
import '../../primary_expression.dart';



class CheckedExpression implements PrimaryNoArrayCreationExpression {
  CheckedExpression(
    this._value,
  ) : super();

  static final PrimaryNoArrayCreationExpressionType _type =
      PrimaryNoArrayCreationExpressionType.checked_expression;
  final List _value;

  @override
  PrimaryNoArrayCreationExpressionType get type {
    assert(_type == PrimaryNoArrayCreationExpressionType.checked_expression);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(PrimaryExpression token) {
    return token.type == PrimaryNoArrayCreationExpressionType.checked_expression;
  }
}