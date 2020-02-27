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
    } else {
      stdout.writeln('Yeah, that was probably null or an unexpected input');
    }
  }
}
