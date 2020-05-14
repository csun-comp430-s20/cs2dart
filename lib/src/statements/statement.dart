// stmt.dart obj class file
enum Statementype{
  labeled_statement,
  declaration_statement,
  embedded_statement,
}


abstract class Statement {

  Statement(
    this._value,
  );

  final List _value;

  List get value {
    return _value;
  }

}
