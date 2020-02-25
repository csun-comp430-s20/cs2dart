import 'dart:io';

import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/lexer.dart';

void main(List<String> arguments) {

  while (true) {

    stdout.write('> ');
    var line = stdin.readLineSync();

    if (line == 'exit()') {
      return;
    }

    var lexer = Lexer(line);

    while (true) {
      var token = lexer.nextToken();
      if (token.kind == SyntaxKind.EOFToken) {
        break;
      }
      stdout.write("${token.kind}: '${token.text}'");
      if (token.value != null) {
        stdout.write(' ${token.value}');
      }
      stdout.writeln();
    }

  }
}
