import '../tokens/syntax_token.dart';
import 'token_assist.dart';

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

  SyntaxToken nextToken() {

    // <EOF>
    // <numbers>
    // <whitespace>
    // + - * / ( )
    // <error>

    if (_position >= _text.length) {
      return SyntaxToken(SyntaxKind.EOFToken, _position, '\0', null);
    }

    if (LexerAssist.isDigit(_current)) {

      var start = _position;

      while (LexerAssist.isDigit(_current)) {
        _next();
      }
      
      var end = _position;
      var text = _text.substring(start, end);
      var value = int.tryParse(text);

      return SyntaxToken(SyntaxKind.NumberToken, start, text, value);
    }

    if (LexerAssist.isCSharpLexerCharWhitespace(_current)) {
        
      var start = _position;

      while (LexerAssist.isCSharpLexerCharWhitespace(_current)) {
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
