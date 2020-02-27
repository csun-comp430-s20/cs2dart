// UTF-16, 0 through 9
const _decimalDigits = [48, 49, 50, 51, 52,
                        53, 54, 55, 56, 57];

const _opsAndPuncs = [33, 37, 38, 40, 41, 42, 43, 44,
                      45, 46, 47, 58, 59, 94,
                      123, 124, 
                      125,
                      ];

const _Zs = [32, 160, 5760, 8192, 8193,
             8194, 8195, 8196, 8197, 8198,
             8199, 8200, 8201, 8202, 8239,
             8287, 12288];

bool isDecimalDigit(int character) {
  if (_decimalDigits.contains(character)) {
    return true;
  }
  return false;
}

bool isMemberOfZs(int character) {
  if (_Zs.contains(character)) {
    return true;
  }
  return false;
}

bool isOperatorOrPunctuator(int character) {
  if (_opsAndPuncs.contains(character)) {
    return true;
  }
  return false;
}

bool isKeyword(String keyword) {
  var list = ['abstract', 'as', 'bool', 'break', 'byte', 'case', 'char', 'class', 'const', 'continue',
              'decimal', 'do', 'double', 'else', 'false', 'for', 'foreach', 'if', 'in', 'int',
              'interface', 'internal', 'is', 'long', 'new', 'null', 'object', 'private', 'protected', 'public',
              'readonly', 'return', 'sbyte', 'short', 'static', 'string', 'switch', 'this', 'true', 'typeof',
              'uint', 'ulong', 'ushort', 'void', 'while'];

  if (list.contains(keyword)) {
    return true;
  }
  return false;
}

bool isWhitespace(String line) {

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
