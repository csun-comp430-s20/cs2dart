import 'dart:io';

import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';

void main(List<String> arguments) {

  while (true) {

    stdout.write('> ');
    var line = stdin.readLineSync();

    if (line == 'exit()') {
      return;
    }

    var lexer = Lexer(line);

    var token = lexer.nextToken();
    // it prints keyword tokens :)
    if (token is KeywordToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is IdentifierToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is CharacterLiteralToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is IntegerLiteralToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is StringLiteralToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is InterpolatedStringLiteralToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is OperatorOrPunctuatorToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token is RealLiteralToken) {
      stdout.writeln('${token.runtimeType}: ${token.value}');
    } else if (token == null) {
      stdout.writeln('Yeah, that was probably null or an unexpected input');
    } else {
      stdout.writeln("YEAH, I REALLY DON'T KNOW WHAT YOU GAVE ME");
    }
  }
}
