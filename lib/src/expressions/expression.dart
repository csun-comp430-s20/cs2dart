import 'package:cs2dart/src/abstractions/abstraction.dart';

enum ExpKind {
  Additive,
}

abstract class Exp {

  Exp(this._value, this._kind);

  final String _value;
  final ExpKind _kind;
} 