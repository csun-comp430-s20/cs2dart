import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/lexer.dart';

bool isType(Token tkn) {
  if (tkn is Token)

  if (isValueType(tkn) ||
      isReferenceType(tkn) ||
      isTypeParameter(tkn)) {
        return true;
  }
  return false;
}

bool isValueType(Token tkn) {
  if (isStructType(tkn) ||
      isEnumType(tkn)) {
        return true;
  }
  return false;
}

bool isStructType(Token tkn) {
  if (isTypeName(tkn) ||
      isSimpleType(tkn) ||
      isNullableType(tkn)) {
        return true;
  }
  return false;
}

bool isSimpleType(Token tkn) {
  if (isNumericType(tkn) ||
      (tkn is KeywordToken && tkn.value == 'bool')) {
        return true;
  }
  return false;
}

bool isNumericType(Token tkn) {
  if (isIntegralType(tkn) ||
      isFloatingPointType(tkn) ||
      (tkn is KeywordToken && tkn.value == 'decimal')) {
        return true;
  }
  return false;
}

bool isIntegralType(Token tkn) {
  if (tkn is KeywordToken) {
    if (tkn.value == 'sbyte' ||
        tkn.value == 'byte' ||
        tkn.value == 'short' ||
        tkn.value == 'ushort' ||
        tkn.value == 'int' ||
        tkn.value == 'uint' ||
        tkn.value == 'long' ||
        tkn.value == 'ulong' ||
        tkn.value == 'char') {
          return true;
    }
  }
  return false;
}

bool isFloatingPointType(Token tkn) {
  if (tkn is KeywordToken) {
    if (tkn.value == 'float' ||
        tkn.value == 'double') {
          return true;
    }
  }
  return false;
}

bool isNullableType(Token tkn) {
  
  var lexer;

  try {
    lexer = Lexer(tkn.value.substring(0, tkn.value.length - 1));
  } on RangeError {
    
    return false;

  } finally {

    Token newTkn = lexer.nextToken();

    if (isType(newTkn) &&
      tkn.value.endsWith('?')) {
        return true;
    }
    return false;
  }  
}

bool isEnumType(Token tkn) {

  if (isTypeName(tkn.value)) {
    return true;
  }
  return false;
    
}

bool isReferenceType(Token tkn) {
  if (isClassType(tkn) ||
      isInterfaceType(tkn) ||
      isArrayType(tkn) ||
      isDelegateType(tkn)) {
        return true;
  }
  return false;
}

bool isClassType(Token tkn) {
  if (isTypeName(tkn) ||
      tkn.value == 'object' ||
      tkn.value == 'dynamic' ||
      tkn.value == 'string') {
        return true;
  }
  return false;
}

bool isInterfaceType(Token tkn) {
  if (isTypeName(tkn)) {
    return true;
  }
  return false;
}

bool isArrayType(Token tkn) {
  
}
