import '../primary_no_array_creation_expression.dart';
import '../../primary_expression.dart';



class Unary implements PrimaryNoArrayCreationExpression {
  Unary(
    this._value,
  ) : super();

  static final PrimaryNoArrayCreationExpressionType _type =
      PrimaryNoArrayCreationExpressionType.unary;
  final List _value;

  @override
  PrimaryNoArrayCreationExpressionType get type {
    assert(_type == PrimaryNoArrayCreationExpressionType.unary);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  // @override
  // bool equals(PrimaryExpression token) {
  //   return token.type == PrimaryNoArrayCreationExpressionType.simple_name;
  // }
}