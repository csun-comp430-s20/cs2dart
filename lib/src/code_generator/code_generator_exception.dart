class CodeGeneratorException implements Exception {
  
  const CodeGeneratorException([this.message = '']);

  final String message;

  @override
  String toString() {
    return (message == null) ? 'CodeGeneratorException' :
      "CodeGeneratorException: '$message'";
  }
}
