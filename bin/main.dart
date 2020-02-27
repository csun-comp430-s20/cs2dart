import 'dart:io';

import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';

void main(List<String> arguments) {

  // isWhitespace(' ');

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
      print(token.value);
    }
  }
}
