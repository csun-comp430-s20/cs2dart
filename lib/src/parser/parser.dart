import 'package:cs2dart/tokens.dart';

class Parser {

    // Parser(String _text) {
    //   var tokens = [];

    //   var lexer = Lexer(_text);

    //   SyntaxToken token;
    //   do {
    //     token = lexer.nextToken();

    //     if (token.kind != SyntaxKind.WhitespaceToken &&
    //         token.kind != SyntaxKind.ErrorToken) {
    //           tokens.add(token);
    //         }

    //   } while (token.kind != SyntaxKind.EOFToken);

    //   _listOfTokens = tokens;
    // }

    Parser(this._tokens);

    final List<Token> _tokens;
    int _position;

    Token peek(int offset) {
      var index = _position + offset;
      if (index >= _tokens.length) {
        return _tokens[_tokens.length - 1];
      }
      return _tokens[index];
    }
    
  }
