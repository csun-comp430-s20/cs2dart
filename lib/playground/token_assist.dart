class TokenAssist {

  /// isCSharpLexerWhitespace
  static bool isCSharpLexerWhitespace(String line) {

    var list = ['\u{0009}', '\u{000B}', '\u{000C}', '\u{0020}',
                '\u{00A0}', '\u{1680}', '\u{2000}', '\u{2001}',
                '\u{2002}', '\u{2003}', '\u{2004}', '\u{2005}',
                '\u{2006}', '\u{2007}', '\u{2008}', '\u{2009}',
                '\u{200A}', '\u{202F}', '\u{205F}', '\u{3000}'];

    if (list.contains(line)) {
      return true;
    }

    return false;   
  }

  static bool isCSharpLexerCharWhitespace(int character) {

    var list = ['\u{0009}', '\u{000B}', '\u{000C}', '\u{0020}',
                '\u{00A0}', '\u{1680}', '\u{2000}', '\u{2001}',
                '\u{2002}', '\u{2003}', '\u{2004}', '\u{2005}',
                '\u{2006}', '\u{2007}', '\u{2008}', '\u{2009}',
                '\u{200A}', '\u{202F}', '\u{205F}', '\u{3000}'];

    var str = String.fromCharCode(character);

    if (list.contains(str)) {
      return true;
    }

    return false;   
  }

  static bool isDigit(int character) {

    var list = ['\u{0030}', '\u{0031}', '\u{0032}', '\u{0033}',
                '\u{0034}', '\u{0035}', '\u{0036}', '\u{0037}'
                '\u{0038}', '\u{0039}'];

    var str = String.fromCharCode(character);

    if (list.contains(str)) {
      return true;
    }

    return false;
  }

  /// isCSharpWhitespace
  static bool isCSharpWhitespace(String line) {

    var list = ['\u{0009}', '\u{000A}', '\u{000B}', '\u{000C}',
                '\u{000D}', '\u{0020}', '\u{0085}', '\u{00A0}',
                '\u{1680}', '\u{2000}', '\u{2001}', '\u{2002}',
                '\u{2003}', '\u{2004}', '\u{2005}', '\u{2006}',
                '\u{2007}', '\u{2008}', '\u{2009}', '\u{200A}',
                '\u{2028}', '\u{2029}', '\u{202F}', '\u{205F}',
                '\u{3000}', '\u{FEFF}'];

    if (list.contains(line)) {
      return true;
    }

    return false;
  }
}


