import 'package:cs2dart/tokens.dart';

import 'lexer_assist.dart' as lexer_assist;
import 'package:characters/characters.dart' as characters;
import 'package:unicode/unicode.dart' as unicode;

class Lexer {

  Lexer(
    this._text
  ): _position = 0;

  final String _text;
  int _position;

  int get _current {
    if (_position >= _text.length) {
      return 0;
    }
    return _text.codeUnitAt(_position);
  }

  void _next() {
    _position++;
  }












  // HELPER FUNCTIONS

  bool _isCSharpWhitespace(int char) {
    if (unicode.isSpaceSeparator(char) ||
        char == 9 ||
        char == 11 ||
        char == 12) {
      return true;
    }
    return false;
  }

  bool _isLetterCharacter(int char) {
    if (unicode.isUppercaseLetter(char) ||
        unicode.isLowercaseLetter(char) ||
        unicode.isTitlecaseLetter(char) ||
        unicode.isModifierLetter(char) ||
        unicode.isOtherLetter(char) ||
        unicode.isLetterNumber(char)) {
      return true;
    }

    return false;
  }

  bool _isDecimalDigitCharacter(int char) {
    if (unicode.isDecimalNumber(char)) {
      return true;
    }
    return false;
  }

  bool _isConnectingCharacter(int char) {
    if (unicode.isConnectorPunctuation(char)) {
      return true;
    }
    return false;
  }

  bool _isCombiningCharacter(int char) {
    if (unicode.isNonspacingMark(char) ||
        unicode.isSpacingMark(char)) {
      return true;
    }
    return false;
  }

  bool _isFormattingCharacter(int char) {
    if (unicode.isFormat(char)) {
      return true;
    }
    return false;
  }

  bool isNewLineCharacter(int char) {
    if (char == 13 || // return carriage
        char == 10 || // line feed
        char == 133 ||
        char == 8232 ||
        char == 8233) {
      return true;
    }
    return false;
  }






  bool _isSingleCharacter(int char) {
    if (char != 39 || // '
        char != 92 || // \
        !isNewLineCharacter(char)) {
      return true;
    }
    return false;
  }




  // HELPER FUNCTIONS








  List<Token> lexify() {
    var tokens = <Token>[];
    while (_position < _text.length) {
      _skipWhitespace();
      if (_position < _text.length) {
        tokens.add(nextToken());
      }
    }
    return tokens;
  }

  // skip pass unicode whitespace
  void _skipWhitespace() {
      while (_isCSharpWhitespace(_current) &&
            _position < _text.length) {
        _next();
      }
  }

  Token characterLiteral() {
    var chunk = '';
    var end;
    var start = _position;

    if (_current == "'".codeUnitAt(0)) {
      _next();
      if (_isSingleCharacter(_current)) {
        _next();
        if (_current == "'".codeUnitAt(0)) {
          _next();
          end = _position;
          chunk = _text.substring(start, end);

          return CharacterLiteralToken(chunk);

        }
      }
    }
    return null;
  }

  Token identifierOrKeyword() {
    var chunk = '';
    var end;
    var start = _position;

    // does it start with a '_' or a letterCharacter???
    if (_current == '_'.codeUnitAt(0) ||
        _isLetterCharacter(_current)) {
      _next();
      // go through on all of these different types of characters
      while(_isLetterCharacter(_current) ||
            _isDecimalDigitCharacter(_current) ||
            _isConnectingCharacter(_current) ||
            _isCombiningCharacter(_current) ||
            _isFormattingCharacter(_current)) {
        _next();
      }
      end = _position;
      chunk = _text.substring(start, end);

      // chunk ended up being a keyword
      if (lexer_assist.isKeyword(chunk)) {
        return KeywordToken(chunk);
      }

      // its an identifier
      return IdentifierToken(chunk);

    } else {
      // doesn't even start correctly
      return null;
    }
  }

  Token nextToken() {
    var read = identifierOrKeyword();
    if (read != null) {
      return read;
    } else {
      return null;
      // read = 
      // do other stuff
    }
  }
}
