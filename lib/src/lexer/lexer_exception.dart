class LexerException implements Exception {
  
  const LexerException([this.message = '']);

  final String message;

  @override
  String toString() {
    return (message == null) ? 'LexerException' :
      "LexerException: '$message'";
  }
}
