class ParseException implements Exception {

  const ParseException([this.message = '']);

  final String message;

  @override
  String toString() {
    return (message == null) ? 'LexerException' :
      "ParserException: '$message'";
  }
}
