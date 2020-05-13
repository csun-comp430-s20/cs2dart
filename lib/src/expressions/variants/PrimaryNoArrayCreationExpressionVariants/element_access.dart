import '../primary_no_array_creation_expression.dart';
import '../../primary_expression.dart';



class ElemenAccess implements PrimaryNoArrayCreationExpression {
  ElemenAccess(
    this._value,
  ) : super();

  static final PrimaryNoArrayCreationExpressionType _type =
      PrimaryNoArrayCreationExpressionType.element_access;
  final List _value;

  @override
  PrimaryNoArrayCreationExpressionType get type {
    assert(_type == PrimaryNoArrayCreationExpressionType.element_access);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

  @override
  bool equals(PrimaryExpression token) {
    return token.type == PrimaryNoArrayCreationExpressionType.element_access;
  }
}