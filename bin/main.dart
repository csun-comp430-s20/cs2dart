import 'dart:io';

import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/parser.dart';

void main(List<String> arguments) {

  while (true) {

    stdout.write('> ');
    var line = stdin.readLineSync();

    if (line == 'exit()') {
      return;
    }

    var lexer = Lexer(line);
    // var token = lexer.nextToken();
    // whichToken(token);

    var listOfTokens = lexer.lexify();

    try {
      listOfTokens.forEach((token) {
        stdout.writeln('${token.runtimeType}: ${token.value}');
      });
    } on LexerException {
      stdout.writeln('Unrecognized expression.');
      break;
    } on NoSuchMethodError {
      stdout.writeln('Unrecognized expression.');
      break;
    }
  }
}

// we are saving this for later
// do not use this unless you are
// testing individual potential tokens
void whichToken(Token token) {
  // it prints keyword tokens :)
  // KeywordToken
  if (token is KeywordToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // Identifier Token
  } else if (token is IdentifierToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // CharacterLiteralToken
  } else if (token is CharacterLiteralToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // IntegerLiteralToken
  } else if (token is IntegerLiteralToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // String Literal Token
  } else if (token is StringLiteralToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // OperatorOrPunctuatorToken
  } else if (token is OperatorOrPunctuatorToken) {
    stdout.writeln('${token.runtimeType}: ${token.value}');
  // Unrecognized input given to token
  } else if (token == null) {
    stdout.writeln('Yeah, that was probably null or an unexpected input');
  // Something EXTREMEMLY UNRECOGNIZED
  } else {
    stdout.writeln("YEAH, I REALLY DON'T KNOW WHAT YOU GAVE ME");
  }
}

