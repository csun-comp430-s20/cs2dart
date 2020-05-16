import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/local_variable_declaration.dart';
import 'package:cs2dart/src/tokens/token.dart';
import 'package:cs2dart/src/types/type.dart';
import 'package:cs2dart/src/types/variants/value_type.dart';
import 'package:cs2dart/src/types/variants/variants/floating_point_type.dart';
import 'package:cs2dart/src/types/variants/variants/integral_type.dart';
class ClassGenerator {
  ClassGenerator(this._namespace);
    
    
    final Namespace _namespace;

    String genCode(){
      String output = '';
      for(int i = 0; i < _namespace.value.length; i++){
        output += genClassCode(_namespace.value[i]);
      }
    }

    String genClassCode(ClassDeclaration classinput){
      String output = '';
      output += classinput.value[0].value + ' ';
      output += classinput.value[1].value + ' ';
      
      for (int i = 2; i < classinput.value.length; i++){
        if(classinput.value[i] is ClassBase){
          output += genClassBaseCode(classinput.value[i]) + ' ';
        }
        else if(classinput.value[i] is ClassBody){
          output += genClassBodyCode(classinput.value[i]) + ' ';
        }
      }
      return output;
    }

    String genClassBaseCode(ClassBase classBase){
      var output = '';
      output += 'extends ';
      output += classBase.value[1].value;
      return output;

    }

    String genClassBodyCode(ClassBody classBody){
      var output = '';
      output += classBody.value[0].value + ' ';
      int i = 1;
      while(i < classBody.value.length -1){
        if(classBody.value[i] is ConstantDeclaration){
          output += genConstDeclarationCode(classBody.value[i]);
          output += '; ';
          i += 2;
        }
        else if(classBody.value[i] is LocalVariableDeclaration){
          output += genLocalVariableDeclarationCode(classBody.value[i]);
          output += '; ';
          i += 2;
        }
        else if(classBody.value[i] is MethodDeclaration){
          output += genMenthodDeclarationCode(classBody.value[i]) + ' ';

        }
        else{
          output += genConstructorDeclorationCode(classBody.value[i]) + ' ';
        }
      }
      output += '}';
      return output;
    }

  String genConstDeclarationCode(ConstantDeclaration value) {
    var output = '';
    output += value.value[0].value + ' ';
    output += genTypeCode(value.value[1]) + ' ';
    output += value.value[2] + ' ';
    if(value.value.length > 3){
      output += value.value[3].value + ' ';
      output += genExpressionCode(value.value[4]) + ' ';
    }
    return output;
  }

  String genTypeCode(Type input){
    var output = '';
    if(input.runtimeType.toString() == 'ValueType'){
      output += genValueTypeCode(input.value[0]) + ' ';
    }
    else{
      output += genReferenceTypeCode(input.value[0]) + ' ';
    }
    return output;
  }

  String genValueTypeCode(ValueType input){
    var output = '';
    if(input.value[0] is Token){
      output += input.value[0].value + ' ';
      return output;
    }
    else if(input.value[0] is FloatingPointType){
      output += genFloatingPointType(input.value[0]) + ' ';
      return output;
    }
    else{
      output += genIntegralType(input.value[0]) + ' ';
      return output;
    }
  }

  String genFloatingPointType(FloatingPointType input){
    var output = '';
    output += input.value[0].value + ' ';
    return output;
  }

  String genIntegralType(IntegralType input){
    var output = '';
    output += input.value[0].value + ' ';
    return output;
  }
  
}
