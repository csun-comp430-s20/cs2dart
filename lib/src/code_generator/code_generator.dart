import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/ConstructorDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/variants/FixedParam.dart';
import 'package:cs2dart/src/expressions/primary_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/additive_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/assignment_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/conditional_and_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/conditional_or_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/equality_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/invocation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/literal.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/member_access.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/multiplicative_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/object_creation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/parenthesized_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/relational_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/simple_name.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/this_access.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/typeof_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/unary.dart';
import 'package:cs2dart/src/expressions/variants/primary_no_array_creation_expression.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/tokens/variants/keyword_token.dart';
import 'package:cs2dart/src/types/variants/reference_type.dart';
import 'package:cs2dart/src/types/variants/value_type.dart';
import 'package:cs2dart/src/types/variants/variants/floating_point_type.dart';
import 'package:cs2dart/src/types/variants/variants/integral_type.dart';
import 'package:cs2dart/src/statements/statement.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/expressions.dart';
import 'package:cs2dart/types.dart';
import 'package:cs2dart/statement.dart';
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
        i++;
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
      if(input.value[0] is KeywordToken){ //method is void
        output += input.value[0].value + ' ';
      }
      else{
        output += genTypeCode(input.value[0]) + ' ';
      }
      output += input.value[1].value;
      output += input.value[2].value;
      var i = 3;
      //parameters
      while(i < input.value.length - 1){
        if (input.value[i].value == ')' && ((i+1) == input.value.length - 1))
        {
          output += ')';
          i++;
        }
        else
        {
          output += genFixedParam(input.value[i]);
          if(i < input.value.length - 2){
            output += ', ';
          }
          i++;
        }
      }
      print('===============Debugcomment=============15');
      print(input.value);
      if (input.value is List)
      {
        for (var t = 0; t < input.value.length; t++)
        {
          print('===============Debugcomment=============777');
          print(input.value[t].value);
          if (!(input.value[t] is Block))
          {
            output += input.value[t].value + ' ';
          }
          else
          {
            output += genBlockStatement(input.value[t]) + '}';
          }
        }
      }
      // i++;
      return output;
    }
    String genBlockStatement(Block input){
      // print(input.value[t].value);
      var output = '';
      //beginning bracket of code
      output += input.value[0].value + ' ';
      var i = 1;
      //for the list of statements
      while (i < input.value.length){
        //checks for end of block. Block types will always have a "}" at the end of list.
        print('===============Debugcomment=============00');
        print(input.value[i]);
        if (i == input.value.length - 1)
        {
          print('====Debugcomment Statement finished====99');
          print(input.value[i]);
          output += '} ';
          print(output);
        }
        else
        {
          print('===============Debugcomment=============88');
          output += genStatements(input.value[i]) + ' ';
          print(output);
        }
        i++;
      }
      // output+= input.value[i].value + ' ';
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
      var output = '';
      
      if (input.value[0] is InvocationExpression){
        output += genInvocation(input.value[0]);
      }
      else if(input.value[0] is ObjectCreationExpression){
        output += genObjectCreation(input.value[0]);
      }
      else{
        output += genAssignmentExpression(input.value[0]);
      }

      output += ';';
      return output; 

      //is this replaced by getExpressionCode??

    }

    String genIterationStatement(IterationStatement input){
      var output = '';
      if(input is ForStatement){
        // output += genForStatement(input);
      }
      else{
        // output += genWhileStatement(input);
      }
      return output;
    }


    String genTypeOf(TypeOfExpression input){
      var output = '';
      output += input.value[2].value;
      output += '.runtimeType';
      return output;
    }

    String genParenthesizedExpression(ParenthesizedExpression input){
      var output = '';
      output += '(';
      output += genExpressionCode(input.value[1]);
      output += ')';
      return output;
    }

    String genMemberAccess(MemberAccess input){
      var output = '';
      if(input.value[0] is Type){
        output += genTypeCode(input.value[0]);
      }
      else if(input.value[0] is ThisAccess){
        output += 'this';
      }
      else{
        output += genSimpleName(input.value[0]);
      }
      output += '._';
      output += input.value[2].value;
      return output;
    }

    String genInvocation(InvocationExpression input){
      var output = '';
      if(input.value[0] is SimpleName){
        output += genSimpleName(input.value[0]);
      }
      else if(input.value[0] is Literal){
        output += genLiteral(input.value[0]);
      }
      else{
        output += genMemberAccess(input.value[0]);
      }
      output += '(';
      int i = 1;
      while(input.value[i].value != ')'){
        output += input.value[i].value;
        i++;
      }
      output +=  ')';
      return output;
      
    }

    String genLiteral(Literal input){
      var output = '';
      output += input.value[0].value;
      return output;
    }

    String genObjectCreation(ObjectCreationExpression input){
      var output = '';
      output += 'new ';
      output += genReferenceTypeCode(input.value[1]);
      output += '(';
      int i = 3;
      while(input.value[i].value != ')'){
        output += input.value[i].value;
      }
      output += ')';
      return output;
    }

    String genPrimaryExpression(PrimaryExpression input){
      var output = ' ';
      if (input is TypeOfExpression){
        output += genTypeOf(input);
        return output;
      }
      else if(input is ParenthesizedExpression){
        output += genParenthesizedExpression(input);
        return output;
      }
      else if(input is MemberAccess){
        output += genMemberAccess(input);
        return output;
      }
      else if(input is InvocationExpression){
        output += genInvocation(input);
        return output;
      }
      else if(input is ThisAccess){
        output += 'this';
        return output;
      }
      else if(input is ObjectCreationExpression){
        output += genObjectCreation(input);
        return output;
      }
      else if(input is Literal){
        output += genLiteral(input);
        return output;
      }
      else if(input is SimpleName){
        output += genSimpleName(input);
        return output;
      }
      else{
        output += genUnary(input);
        return output;
      }
    }


    String genAssignmentExpression(AssignmentExpression input){
      var output = '';
      output += genExpressionCode(input.value[0]);
      output += input.value[1].value + ' ';
      output += genExpressionCode(input.value[2]) + ' ';
      return output;
    }

    String genAdditiveExpression(AdditiveExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genMultiplicativeExpression(MultiplicativeExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genEqualityExpression(EqualitylExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genRelationalExpression(RelationalExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genConditionalAndExpression(ConditionalAndExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genConditionalOrExpression(ConditionalOrExpression input){
      var output = '';
      output += genPrimaryExpression(input.value[0]);
      output += input.value[1].value + ' ';
      output += genPrimaryExpression(input.value[2]) + ' ';
      return output;
    }

    String genSimpleName(SimpleName input){
      var output = '';
      output += input.value[0].value + ' ';
      return output;
    }

    String genExpressionCode(PrimaryNoArrayCreationExpression input){
      var output = '';
      if (input is PrimaryExpression){
        output += genPrimaryExpression(input) + ' ';
      }
      else if(input is AssignmentExpression){
        output += genAssignmentExpression(input) + ' ';
      }
      else if(input is AdditiveExpression){
        output += genAdditiveExpression(input) + ' ';
      }
      else if(input is MultiplicativeExpression){
        output += genMultiplicativeExpression(input) + ' ';
      }
      else if(input is EqualitylExpression){
        output += genEqualityExpression(input) + ' ';
      }
      else if(input is RelationalExpression){
        output += genRelationalExpression(input) + ' ';
      }
      else if(input is ConditionalAndExpression){
        output += genConditionalAndExpression(input) + ' ';
      }
      else if(input is ConditionalOrExpression){
        output += genConditionalOrExpression(input) + ' ';
      }
      else if(input is SimpleName){
        output += genSimpleName(input);
      }
      else{
        output += genUnary(input) + ' ';
      }
      return output;
    }
    
    String genUnary(Unary input){
      var output = '';
      output += input.value[0].value;
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



    // String genForStatement(ForStatement input){
    //   var output ='';
    //   output += input.value[0].value + ' ';
    //   output += input.value[1].value + ' ';
    //   output += genLocalVariableDeclarationCode(input.value[2]);
    //   output += input.value[3].value + ' ';
    //   output += genExpressionCode(input.value[4]);
    //   output += input.value[5].value + ' ';
    //   output += genExpressionStatement(input.value[6]);
    //   output += input.value[7].value;
    //   output += genEmbeddedStatement(input.value[8]) + ' ';
    //   return output;
    // }
    //
    // String genWhileStatement(WhileStatement input){
    //   var output = '';
    //   output += input.value[0].value + ' ';
    //   output += input.value[1].value + ' ';
    //   output += genExpressionCode(input.value[2]);
    //   output += input.value[3] + ' ';
    //   output += genEmbeddedStatement(input.value[4]) + ' ';
    //
    //   return output;
    // }
    //
    // String genJumpStatement(JumpStatement input){
    //   var output = '';
    //   output += input.value[0].value + ' ';
    //   output += genExpressionCode(input.value[1]) + ' ';
    //   output += input.value[2].value + ' ';
    //   return output;
    // }
    //
    // String genSelectionStatement(SelectionStatement input){
    //   var output = '';
    //   output += input.value[0].value + ' ';
    //   output += input.value[1].value + ' ';
    //   output += genExpressionCode(input.value[2]) + ' ';
    //   output += input.value[3].value + ' ';
    //   output += genEmbeddedStatement(input.value[4]);
    //   if(input.value.length > 5){
    //     output += input.value[5].value + ' ';
    //     output += genEmbeddedStatement(input.value[6]) + ' ';
    //   }
    //   return output;
    // }




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
      // else if(input is JumpStatement){
      //   output += genJumpStatement(input);
      //   return output;
      // }
      // else if(input is SelectionStatement){
      //   output += genSelectionStatement(input);
      //   return output;
      // }
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
      print('===============Debugcomment=============365');
      print(input.value);
      output += genTypeCode(input.value[0]);
      output += genLocalVariabelDeclaratorCode(input.value[1]);
      return output;
    }
  //
    String genLocalVariabelDeclaratorCode(LocalVariableDeclarator input){
      var output = '';
      print('===============Debugcomment=============42');
      print(input.value);
      print(input);
      output += input.value[0].value + ' ';
      if (input.value.length > 1){
        output += input.value[1].value + ' ';
        output += genLocalVariableInitializer(input.value[2]);

      }
      return output;
    }
    String genLocalVariableInitializer(LocalVariableInitializer input){
      var output = '';
      print(input.value);

      if (input.value[0] is Literal && input.value.length == 1)
      {
        //the value of the literal is placed
        output += input.value[0].value[0].value;
      }
      else
      {
        output += genExpressionCode(input.value[0]) + ' ';
      }
      print(output);
      return output;
    }
  //
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

  String genExpressionCode(PrimaryExpression input)
  {
    print('AAAAAAAAAAAAAAAAAAAAAH this needs to be written');
    //Were this method to be called, the following error would occur during testing, since output is null.

    //Error:
    // NoSuchMethodError: The method '+' was called on null.
    // Receiver: null
    // Tried calling: +(" ")


    var output;
    return output;
  }

//========================================================================

  String genTypeCode(LocalVariableType input){
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
