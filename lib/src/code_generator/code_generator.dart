import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/ConstructorDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/variants/FixedParam.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/LocalVariableDeclarationVariants/LocalVariableDeclaratorsVariants/LocalVariableDeclaratorVariants/local_variable_initializer.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/LocalVariableDeclarationVariants/LocalVariableDeclaratorsVariants/local_variable_declarator.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/local_variable_declaration.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/IterationStatementVariants/for_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/IterationStatementVariants/while_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/block.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/empty_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/expression_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/iteration_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/jump_statement.dart';
import 'package:cs2dart/src/statements/variants/EmbeddedStatementVariants/selection_statement.dart';
import 'package:cs2dart/src/statements/variants/declaration_statement.dart';
import 'package:cs2dart/src/statements/variants/embedded_statement.dart';
import 'package:cs2dart/src/tokens/token.dart';
import 'package:cs2dart/src/tokens/variants/keyword_token.dart';
import 'package:cs2dart/src/types/type.dart';
import 'package:cs2dart/src/types/variants/reference_type.dart';
import 'package:cs2dart/src/types/variants/value_type.dart';
import 'package:cs2dart/src/types/variants/variants/floating_point_type.dart';
import 'package:cs2dart/src/types/variants/variants/integral_type.dart';
import 'package:cs2dart/src/statements/statement.dart';
class ClassGenerator {
  ClassGenerator(this._namespace);
    
    
    final Namespace _namespace;

    String genCode(){
      var output = '';
      for(var i = 0; i < _namespace.value.length; i++){
        output += genClassCode(_namespace.value[i]);
      }
      return output;
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

    String genConstructorDeclorationCode(ConstructorDeclaration input){
      var output = '';
      output += input.value[0].value + ' ';
      output += input.value[1].value + ' ';
      int i = 2;
      while(i < input.value.length - 1){
        output += genFixedParam(input.value[i]);
        if(i < input.value.length - 2){
          output += ', ';
        }
        i++;
      }
      output += input.value[i].value + ' ';
      i++;
      output += genBlockStatement(input.value[i]) + ' ';
      return output;
    }
   
   
    String genMenthodDeclarationCode(MethodDeclaration input){
      var output = '';
      if(input.value[0] is KeywordToken){//method is void
        output += input.value[0].value + ' '; 
      }
      else{
        output += genTypeCode(input.value[0]) + ' ';
      }
      output += input.value[1].value;
      output += input.value[2].value;
      int i = 3;
      while(i < input.value.length - 1){
        output += genFixedParam(input.value[i]);
        if(i < input.value.length - 2){
          output += ', ';
        }
        i++;
      }
      output += input.value[i].value + ' ';
      i++;
      output += genBlockStatement(input.value[i]) + ' ';
      return output;
    }
    String genBlockStatement(Block input){
      var output;
      output += input.value[0].value + ' ';
      int i = 1;
      while (i < input.value.length - 1){
        output += genStatements(input.value[i]) + ' ';
        i++;
      }
      output+= input.value[i].value + ' ';
      return output;
    }

    String genStatements(Statement input){
      var output = '';
      if (input is DeclarationStatement){
        output += genDeclarationStatement(input) + ' ';
      }
      else{
        output += genEmbeddedStatement(input) + ' ';
      }
      return output;
      
    }
  
    String genExpressionStatement(ExpressionStatement input){

    }

    String genIterationStatement(IterationStatement input){
      var output = '';
      if(input is ForStatement){
        output += genForStatement(input);
      }
      else{
        output += genWhileStatement(input);
      }
      return output;
    }

    

    String genForStatement(ForStatement input){
      var output ='';
      output += input.value[0].value + ' ';
      output += input.value[1].value + ' ';
      output += genLocalVariableDeclarationCode(input.value[2]);
      output += input.value[3].value + ' ';
      output += genExpressionCode(input.value[4]);
      output += input.value[5].value + ' ';
      output += genExpressionStatement(input.value[6]);
      output += input.value[7].value;
      output += genEmbeddedStatement(input.value[8]) + ' ';
      return output;
    }

    String genWhileStatement(WhileStatement input){
      var output = '';
      output += input.value[0].value + ' ';
      output += input.value[1].value + ' ';
      output += genExpressionCode(input.value[2]);
      output += input.value[3] + ' ';
      output += genEmbeddedStatement(input.value[4]) + ' ';

      return output;
    }

    String genJumpStatement(JumpStatement input){
      var output = '';
      output += input.value[0].value + ' ';
      output += genExpressionCode(input.value[1]) + ' ';
      output += input.value[2].value + ' ';
      return output;
    }

    String genSelectionStatement(SelectionStatement input){
      var output = '';
      output += input.value[0].value + ' ';
      output += input.value[1].value + ' ';
      output += genExpressionCode(input.value[2]) + ' ';
      output += input.value[3].value + ' ';
      output += genEmbeddedStatement(input.value[4]);
      if(input.value.length > 5){
        output += input.value[5].value + ' ';
        output += genEmbeddedStatement(input.value[6]) + ' ';
      }
      return output;
    }




    String genEmbeddedStatement(EmbeddedStatement input){
      var output = '';
      if(input is Block){
        output += genBlockStatement(input);
        return output;
      }
      else if(input is EmptyStatement){
        return output;
      }
      else if(input is ExpressionStatement){
        output += genExpressionStatement(input);
        return output;
      }
      else if(input is IterationStatement){
        output += genIterationStatement(input);
        return output;
      }
      else if(input is JumpStatement){
        output += genJumpStatement(input);
        return output;
      }
      else if(input is SelectionStatement){
        output += genSelectionStatement(input);
        return output;
      }
      else{
        return null;
      }
    }

    String genDeclarationStatement(DeclarationStatement input){
      var output = '';
      if(input.value[0] is LocalVariableDeclaration){
        output += genLocalVariableDeclarationCode(input.value[0]);
        output += ';';
        return output;
      }
      else{
        output += genConstDeclarationCode(input.value[0]);
        output += ';';
        return output;
      }
    }

    String genFixedParam(FixedParam input){
      var output = '';
      output += genTypeCode(input.value[0]) + ' ';
      output += input.value[1].value;
      return output;
    }

    String genLocalVariableDeclarationCode(LocalVariableDeclaration input){
      var output = '';
      output += genTypeCode(input.value[0]) + ' ';
      output += genLocalVariabelDeclaratorCode(input.value[1]);
      return output;
    }

    String genLocalVariabelDeclaratorCode(LocalVariableDeclarator input){
      var output = '';
      output += input.value[0].value + ' ';
      if (input.value.length > 1){
        output += input.value[1].value + ' ';
        output += genLocalVariableInitializer(input.value[2]);

      }
      return output;
    }
    String genLocalVariableInitializer(LocalVariableInitializer input){
      var output = '';
      output += genExpressionCode(input.value[0]) + ' ';
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

  String genReferenceTypeCode(ReferenceType input){
    var output = '';
    
      if(input.value[0].value == 'object'){
        output += 'Object ';
        return output;
      }
      else if(input.value[0].value == 'string'){
        output += 'String ';
        return output;
      }
      else{
        output += input.value[0].value + ' ';
        return output;
      }
    
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
