import 'dart:io';

import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';

import 'lexer_assist.dart' as lexer_assist;
// import 'package:characters/characters.dart' as characters;
import 'package:unicode/unicode.dart' as unicode;

class Lexer {
  Lexer(this._text) : _position = 0;

  final String _text;
  int _position;

  int get _current {
    if (_position >= _text.length) {
      return 0;
    }
    return _text.codeUnitAt(_position);
  }

  int _lookAt(int offset) {
    return _text.codeUnitAt(_position + offset);
  }

  void _next() {
    _position++;
  }


  // TOP OF HELPER FUNCTIONS
  // MIGHT MOVE TO LEXER ASSIST
  // DON'T KNOW WHERE TO ABSTRACT THESE HELPER FUNCTIONS RN

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
    if (unicode.isNonspacingMark(char) || unicode.isSpacingMark(char)) {
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

  bool _isDoubleQuote(int char) {
    if (char == 34) {
      return true;
    }

    return false;
  }

  bool _isDollarSign(int char){
    if (char == 36){
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

  bool _isCarriageReturn(int char) {
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
    if (char == 13 ||   // return carriage
        char == 10 ||   // line feed
        char == 133 ||  // next line (nel)
        char == 8232 || // line separator
        char == 8233) {
      // paragraph separator
      return true;
    }
    return false;
  }

  bool _isU(int char) {
    if (char == 117 || // u
        char == 85) {
      // U
      return true;
    }
    return false;
  }

  bool _isL(int char) {
    if (char == 76 || // L
        char == 108) {
      // l
      return true;
    }
    return false;
  }

  bool _isDecimalPoint(int char) {
    if (char == 46) {
      return true;
    }
    return false;
  }

  bool _isExponentPart(int char) {
    if (char == 69 || char == 101) {
      return true;
    }
    return false;
  }

  bool _isSign(int char) {
    if (char == 43 || char == 45) {
      return true;
    }
    return false;
  }

  bool _isRealTypeSuffix(int char) {
    if (char == 70 ||
        char == 102 ||
        char == 68 ||
        char == 100 ||
        char == 77 ||
        char == 109) {
      return true;
    }
    return false;
  }

  // DO NOT USE
  bool _isIntegerTypeSuffix(String str) {
    var list = [
      'U',
      'u',
      'L',
      'l',
      'UL',
      'Ul',
      'uL',
      'ul',
      'LU',
      'Lu',
      'lU',
      'lu'
    ];

    if (list.contains(str)) {
      return true;
    }
    return false;
  }

  bool _isDoubleOp(int char)
  {
    if (char == 38 ||  // ampersand
        char == 43 ||  // plus sign
        char == 45 ||  // hyphen-minus
        char == 58 ||  // colon
        char == 60 ||  // less-than sign
        char == 61 ||  // equal sign
        char == 62 ||  // greater-than sign
        char == 63 ||  // question mark
        char == 124) { // vertical bar
      return true;
    }
    return false;
  }

  bool _isEqualsSign(int char)
  {
    if (char == 61) { // equal sign
      return true;
    }
    return false;
  }

  bool _isOperatorOrPunctuator(int char) {
    // single chars
    if (char == 33 || // Exclamation mark
        char == 37 || // percent sign
        char == 38 || // ampersand
        char == 40 || // left parenthesis
        char == 41 || // right parenthesis
        char == 42 || // asterisk
        char == 43 || // plus sign
        char == 44 || //comma
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
        char == 126 ) { // tilde
      return true;
    }
    return false;
  }

  ///  Any character except ' apostrophe,
  ///  \ backwards slash, and C#'s defined
  /// "new_line_character" (refer to _isNewLineCharacter() method)
  bool _isSingleCharacter(int char) {
    if (char != 39 || // '
        char != 92 || // \
        !_isNewLineCharacter(char)) {
      return true;
    }
    return false;
  }

  bool _isOpenBracket(int char) {
    if (char == 123) {
      return true;
    }
    return false;
  }

  bool _isClosedBracket(int char) {
    if (char == 125) {
      return true;
    }
    return false;
  }

  // BOTTOM OF HELPER FUNCTIONS
  // MIGHT MOVE TO LEXER ASSIST

  List<Token> lexify() {
    var tokens = <Token>[];
    while (_position < _text.length) {
      _skipWhitespace();
      if (_position < _text.length) {
        try {
          tokens.add(nextToken());
        } on LexerException {
          stdout.writeln('Unexpected halt ${_text[_position]} at index ${_position} in input String.');
          return null;
        }
      }
    }
    return tokens;
  }

  // skip pass csharp defined whitespace
  void _skipWhitespace() {
    while (_isCSharpWhitespace(_current) && _position < _text.length) {
      _next();
    }
  }

  Token _characterLiteral() {
    var chunk = '';
    var end;
    var start = _position;

    if (_current == 39) { // ' apostrophe
      _next();
      if (_isSingleCharacter(_current)) {
        _next();
        if (_current == 39) { // ' apostrophe
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
    if (_current == '_'.codeUnitAt(0) || _isLetterCharacter(_current)) {
      _next();
      // go through on all of these different types of characters
      while (_isLetterCharacter(_current) ||
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

  Token _interpolatedStringLiteral() {
    var chunk = '';
    var start = _position;
    var end;
    
    if (_isDollarSign(_current)) {
      _next();
      if (_isDoubleQuote(_current)) {
        _next();
        while (!_isBackSlash(_current) &&
              !_isCarriageReturn(_current) &&
              !_isDoubleQuote(_current) && 
              _position < _text.length) {
          if (_isOpenBracket(_current)) {
            _next();
            while (!_isBackSlash(_current) &&
                  !_isCarriageReturn(_current) &&
                  !_isClosedBracket(_current) &&
                  _position < _text.length) {
              _next();
            }
            if(!_isClosedBracket(_current)){
              return null;
            }
          }
          _next();
        }
        if (_isDoubleQuote(_current)){
          _next();
          end = _position;
          chunk = _text.substring(start,end);
          return InterpolatedStringLiteralToken(chunk);
        } else {
          _position = start;
          return null; // illegal character
        }
      }
    }
    _position = start;
    return null;
  }

  Token _stringLiteral() {
    var chunk = '';
    var start = _position;
    var end;

    if (_isDoubleQuote(_current)) {
      _next();
      while (!_isBackSlash(_current) &&
             !_isCarriageReturn(_current) &&
             !_isDoubleQuote(_current) && 
             _position < _text.length) {
        _next();
      }
      if (_isDoubleQuote(_current)) {
        _next();
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

  Token _operatorOrPunctuator() {
    var chunk = '';
    var end;
    var start = _position;

    // go through on all of these different types of characters
    if (_isOperatorOrPunctuator(_current)) {
      _next();
      if (_isDoubleOp(_current)) {
        _next();
        if (_isEqualsSign(_current)) {
          _next();
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
      end = _position;
      chunk = _text.substring(start, end);

      return OperatorOrPunctuatorToken(chunk);

    } else {
      // not correct token
      _position = start;
      return null;
    }
  }

  Token _realLiteral() {
    var chunk = '';
    var end;
    var start = _position;

    if (lexer_assist.isDecimalDigit(_current)) {
      _next();
      while (lexer_assist.isDecimalDigit(_current)
            && _position < _text.length) {
        _next();
      }
      if (_isDecimalPoint(_current)) {
        _next();
      }
      while (lexer_assist.isDecimalDigit(_current)
            && _position < _text.length) {
        _next();
        if (_isExponentPart(_current)) {
          _next();
          if (_isSign(_current)) {
            _next();
            // if (_isRealTypeSuffix(_current)) {
            //   _next();
            // }
          }
          // if (_isRealTypeSuffix(_current)) {
          //   _next();
          // }
        }
        
      }
      if (_isRealTypeSuffix(_current)) {
            _next();
          }
      // form: XXX'.'XXX
      end = _position;
      chunk = _text.substring(start, end);
      return RealLiteralToken(chunk);
    } else if (_isDecimalPoint(_current)) {
      _next();
      //copied from while loop above
      while (lexer_assist.isDecimalDigit(_current)) {
        _next();
        if (_isExponentPart(_current)) {
          _next();
          if (_isSign(_current)) {
            _next();
            // if (_isRealTypeSuffix(_current)) {
            //   _next();
            // }
          }
          // if (_isRealTypeSuffix(_current)) {
          //   _next();
          // }
        }
      }
      if (_isRealTypeSuffix(_current)) {
            _next();
          }
      // form: '.'XXX
      end = _position;
      chunk = _text.substring(start, end);
      return RealLiteralToken(chunk);
    } else {
      // not recognized
      // reset position
      _position = start;
      return null;
    }
  }

  Token nextToken() {
    var read = _identifierOrKeyword();

    if (read != null) {
      return read;
    } else {
      read = _realLiteral();
      if (read != null) {
        return read;
      } else {
        read = _integerLiteral();
        if (read != null) {
          return read;
        } else {
          read = _interpolatedStringLiteral();
          if (read != null) {
            return read;
          } else {
            read = _stringLiteral();
            if (read != null) {
              return read;
            } else {
              read = _characterLiteral();
              if (read != null) {
                return read;
              } else {
                read = _operatorOrPunctuator();
                if (read != null) {
                  return read;
                }
              }
            }
          }
        }
      }
      // i don't know what i just read
      // but it's definetly not supported
      // imma give you an error token back
      throw LexerException('Unexpected character');
    }
  }
}
