class IllTypedException implements Exception {
  
  const IllTypedException([this.message = '']);

  final String message;

  @override
  String toString() {
    return (message == null) ? 'IllTypedException' :
      "IllTypedException: '$message'";
  }
}
