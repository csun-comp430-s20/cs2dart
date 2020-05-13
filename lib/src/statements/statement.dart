// stmt.dart obj class file
enum Statementype{
  labeled_statement,
  declaration_statement,
  embedded_statement,
}


abstract class Statement {

  Statement(
    this._type,
    this._value,
  );

  final Statementype _type;
  final List _value;

  Object get type {
    return _type;
  }

  List get value {
    return _value;
  }
  bool equals(Statement statement){
    return _type == statement.type;
  }

}
