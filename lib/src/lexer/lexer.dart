import 'dart:io';

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

    bool _isDoubleQuote(int char){
    if(char == 34) {
      return true;
    }
      
    return false;
  }

  bool _isBackSlash(int char){
    if(char == 92) {
      return true;
    }
    return false;
  }

  bool _isCarriageReturn(int char){
    if (char == 10) {
      return true;
    }
    return false;
  }

  bool _isGraphicalCharacter(int char) {

    var list = [33, 35, 37, 38, 39,
                40, 41, 42, 43, 44,
                45, 46, 47, 58, 59,
                60, 61, 62, 63, 91, 
                93, 94, 95, 123, 124,
                125, 126];

    if (list.contains(char)) {
      return true;
    }
    return false;
  }
    
  bool _isNewLineCharacter(int char) {
    if (char == 13 || // return carriage
        char == 10 || // line feed
        char == 133 || // next line (nel)
        char == 8232 || // line separator
        char == 8233) { // paragraph separator
      return true;
    }
    return false;
  }

  bool _isU(int char) {
    if (char == 117 || // u
        char == 85) {  // U 
      return true;
    }
    return false;
  }

  bool _isL(int char) {
    if (char == 76 ||  // L
        char == 108) { // l
      return true;
    }
    return false;
  }


  // DON'T USE OMEGALUL
  bool _isIntegerTypeSuffix(String str) {
    var list = ['U', 'u', 'L', 'l',
                'UL', 'Ul', 'uL', 'ul',
                'LU', 'Lu', 'lU', 'lu'];

    if (list.contains(str)) {
      return true;
    }
    return false;
  }
  bool _isDoubleOp(int char)
  {
    if (char == 38 || // ampersand
        char == 43 || // plus sign
        char == 45 || // hyphen-minus
        char == 58 || // colon
        char == 60 || // less-than sign
        char == 61 || // equal sign
        char == 62 || // greater-than sign
        char == 63 || // question mark
        char == 124 // vertical bar
    ) {
      return true;
    }
    return false;
  }

  bool _isTripleOp(int char)
  {
    if (char == 61 // equal sign
    ) {
      return true;
    }
    return false;
  }

  bool _isOperatororPunctuator(int char) {
    var chunk = '';
    var end;
    var start = _position;
    // single chars
    if (char == 33 || // Exclamation mark
        char == 37 || // percent sign
        char == 38 || // ampersand
        char == 40 || // left parenthesis
        char == 41 || // right parenthesis
        char == 42 || // asterisk
        char == 43 || // plus sign
        char == 45 || // hyphen-minus
        char == 46 || // full stop, period
        char == 47 || // slash
        char == 58 || // colon
        char == 59 || // semicolon
        char == 60 || // less-than sign
        char == 61 || // equal sign
        char == 62 || // greater-than sign
        char == 63 || // question mark
        char == 91 || // left square bracket
        char == 93 || // right square bracket
        char == 94 || // circumflex accent
        char == 123 || // left curly bracket
        char == 124 || // vertical bar
        char == 125 || // right curly bracket
        char == 126) { // tilde
          //then check for operators that have 2 characters
      return true;
    }
    return false;
  }


  bool _isSingleCharacter(int char) {
    if (char != 39 || // '
        char != 92 || // \
        !_isNewLineCharacter(char)) {
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

  Token _characterLiteral() {
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

    _position = start;
    return null;
  }

  Token _identifierOrKeyword() {
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
      // not the right token
      // reset position back to what it was
      // so the other functions can check
      // what the parse is
      _position = start;
      return null;
    }
  }

  Token _stringLiteral() {
    var chunk = '';
    var start = _position;
    var end;

    if (_isDoubleQuote(_current)) {
      chunk += '"';
      _next();
      while (!_isBackSlash(_current) &&
             !_isCarriageReturn(_current) &&
             !_isDoubleQuote(_current)) {
        _next();
      }
      if (_isDoubleQuote(_current)){
        chunk += '"';
        end = _position;
        chunk = _text.substring(start,end);
        return StringLiteralToken(chunk);
      } else {
        _position = start;
        return null; // illegal character
      }
    }
    _position = start;
    return null;
  }


  Token _integerLiteral() {
    var chunk = '';
    var end;
    var start = _position;

    if (lexer_assist.isDecimalDigit(_current)) {
      _next();
      while (lexer_assist.isDecimalDigit(_current)) {
        _next();
      }
      if (_isU(_current) || _isL(_current)) {
        _next();
        if (_isU(_current) || _isL(_current)) {
          _next();
        }
      }
      end = _position;
      chunk = _text.substring(start, end);

      return IntegerLiteralToken(chunk);

    } else {
      // not recognized
      // reset position
      _position = start;
      return null;
    }
  }
  Token operatorOrPunctuator() {
    var chunk = '';
    var end;
    var start = _position;
    // go through on all of these different types of characters
    if (_isOperatororPunctuator(_current)){
      _next();
      if (_isDoubleOp(_current))
      {
        _next();
        if (_isTripleOp(_current))
        {
          end = _position;
          chunk = _text.substring(start, end);
          if (lexer_assist.isTripleOp(chunk)) {
            return OperatorOrPunctuatorToken(chunk);
          }
        }
        end = _position;
        chunk = _text.substring(start, end);
        if (lexer_assist.isDoubleOp(chunk)) {
          return OperatorOrPunctuatorToken(chunk);
        }
      }
      chunk = _text.substring(start, end);
      // chunk ended up being a keyword
      if (lexer_assist.isKeyword(chunk)) {
        return KeywordToken(chunk);
      }
      return OperatorOrPunctuatorToken(chunk);
    } else {
      // doesn't even start correctly
      _position = start;
      return null;
    }
  }




  Token nextToken() {

    var read = _identifierOrKeyword();

    if (read != null) {

      return read;

    } else {

      read = _characterLiteral();

      if (read != null) {

        return read;

      } else {

        read = _integerLiteral();

        if (read != null) {

          return read;

        } else {

          // read =

        }

      }

      // yeah idk what I just read imma
      // just give you null back lmao
      return null;
    }
  }
}
