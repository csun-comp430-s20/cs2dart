import 'package:cs2dart/tokens.dart';

import '../../playground/syntax_token.dart';
import '../../playground/token_assist.dart';

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
      // read = 
      // do other stuff
    }
  }





































  // this was orginally a toy function to understand
  SyntaxToken nextToken2() {

    // <EOF>
    // <numbers>
    // <whitespace>
    // + - * / ( )
    // <error>

    if (_position >= _text.length) {
      return SyntaxToken(SyntaxKind.EOFToken, _position, '\0', null);
    }

    if (TokenAssist.isDigit(_current)) {

      var start = _position;

      while (TokenAssist.isDigit(_current)) {
        _next();
      }
      
      var end = _position;
      var text = _text.substring(start, end);
      var value = int.tryParse(text);

      return SyntaxToken(SyntaxKind.NumberToken, start, text, value);
    }

    if (TokenAssist.isCSharpLexerCharWhitespace(_current)) {
        
      var start = _position;

      while (TokenAssist.isCSharpLexerCharWhitespace(_current)) {
        _next();
      }
      
      var length = _position - start;

      return SyntaxToken(SyntaxKind.WhitespaceToken, start, ' ', length);
    }

    if (_current == '+'.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.PlusToken, _position++, '+', null);
    } else if (_current == '-'.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.MinusToken, _position++, '-', null);
    } else if (_current == '*'.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.MultiplyToken, _position++, '*', null);
    } else if (_current == '/'.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.MinusToken, _position++, '/', null);
    } else if (_current == '('.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.OpenParenToken, _position++, '(', null);
    } else if (_current == ')'.codeUnitAt(0)) {
      return SyntaxToken(SyntaxKind.ClosedParenToken, _position++, ')', null);
    }

    return SyntaxToken(SyntaxKind.ErrorToken, _position++, _text.substring(_position - 1, _position), null);
  }



}
