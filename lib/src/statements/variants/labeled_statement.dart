import '../statement.dart';
class LabeledStatement implements Statement {

  LabeledStatement(
    this._value,
  ): super();


  static final Statementype _type = Statementype.labeled_statement;
  final List _value;

  Statementype get type {
    assert(_type == Statementype.labeled_statement);
    return _type;
  }

  @override
  List get value {
    return _value;
  }

 //  @override
 //  bool equals(Statement token){
 //   return token.type == Statementype.labeled_statement;
 // }

}
