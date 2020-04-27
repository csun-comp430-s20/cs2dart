import 'package:cs2dart/tokens.dart';

class ParseNode<A> {
  Token _token;
  ParseNode<A> leftToken;
  ParseNode<A> rightToken;
  ParseNode<A> parent;
  ParseNode(this._token, this.leftToken, this.rightToken);

  Token get token {
    return _token;
  }

  set token(Token _token) {
    this._token = _token;
  }
}
