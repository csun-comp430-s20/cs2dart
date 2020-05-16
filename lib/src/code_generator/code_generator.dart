import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/local_variable_declaration.dart';

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
  
}
