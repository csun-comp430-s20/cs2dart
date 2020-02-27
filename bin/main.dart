import 'dart:io';

import 'package:cs2dart/playground/syntax_token.dart';
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

    while (true) {
      var token = lexer.lexify();
      if (token[1] is KeywordToken) {
        print(token[1]);
      }
    }
  }
}
