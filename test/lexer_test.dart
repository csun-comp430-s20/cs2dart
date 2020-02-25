import 'package:cs2dart/lexer.dart';
import 'package:cs2dart/tokens.dart';
import 'package:test/test.dart';

void main() {

  test("The 'h'ello ascii test", () {
    var token = Lexer('hello').nextToken();
    expect(SyntaxKind.ErrorToken, token.kind);
    expect(0, token.position);
    expect('h', token.text);
    expect(null, token.value);
  });
}
