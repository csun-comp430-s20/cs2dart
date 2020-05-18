import 'dart:collection';
import 'dart:html';

import 'package:cs2dart/expressions.dart';
import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
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
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/this_access.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/typeof_expression.dart';
import 'package:cs2dart/src/interfaces/variants/InterfaceDeclaration.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/typechecker/ill_typed_expection.dart';
import 'package:cs2dart/src/types/variants/variants/floating_point_type.dart';
import 'package:cs2dart/src/types/variants/variants/integral_type.dart';
import 'package:cs2dart/statement.dart';
import 'package:cs2dart/tokens.dart';
import 'package:cs2dart/types.dart';

// Hypothetical imports for the syntax above and below

// Classes are verified by name through constructor
//

class Typechecker {

  // String is in place of recording the TypeDeclaration's name as the Map's key
  // TypeDeclaration is the value of the Map, actual TypeDeclaration objects
  Map<String, ClassDeclaration> _classDeclarations;

  // Done
  // Run this first, then run typecheck namespace, if both are valid, then code generate
  // Constructor for the typechecker, get all of the high level typedeclarations
  Typechecker(final Namespace namespace) {
    _classDeclarations = HashMap<String, ClassDeclaration>();
    for (ClassDeclaration classDec in namespace.value) {
      // value[2].value is the name of the class from the stored token from list
      if (!_classDeclarations.containsKey(classDec.value[1].value)) {
        _classDeclarations[classDec.value[1].value] = classDec;
      } else {
        throw IllTypedException('Duplicate class declaration name: ' + classDec.value[1].value);
      }
    }
  } // Typechecker

  // Done
  // Basically the main
  // There no scope in a Namespace so no map necessary
  // Typechecks the namespace's contents which should be classDeclarations
  void typecheckNamespace(final Namespace namespace) {
    for (ClassDeclaration classDec in namespace.value) {
      typecheckClassDeclaration(classDec);
    }
  } // typecheckNamespace

  // Done
  // Typechecks the class declaration
  // This is just navigation for the class declaration contents
  void typecheckClassDeclaration(final ClassDeclaration classDec) {
    var i = 0;
    // walk through the class declaration loop because body and base can be in a not nice order
    while (i < classDec.value.length - 1) {
      var object = classDec.value[i];
      // classDec.value[1].value is the name of the class in the Identifier token
      // just after the class keyword token
      if (object.runtimeType == ClassBase) {
        typecheckClassBase(object, classDec.value[1].value);
      } else if (object.runtimeType == ClassBody) {
        typecheckClassBody(object, classDec.value[1].value);
      } else {
        throw IllTypedException('Invalid class body format: ' + classDec.value[1].value);
      }
      i++;
    }
  }

  // Done
  // I hope the exceptions work
  void typecheckClassBase(final ClassBase classBase, final String className) {
    if (_classDeclarations.containsKey(classBase.value[1].value) ||
        classBase.value[1].value == 'Object') { // Support the BIG Object object
        // is it object or object
      // The extends is valid
      return;
    } else {
      throw IllTypedException('Class ' + className +
        'extends non-existant class: + classBase.value[0].value');
    }
  }

  // Typecheckes the class body objects
  void typecheckClassBody(final ClassBody classBody, final String className) {

    // listOfConstantDeclarationName
    Map<String, ConstantDeclaration> listOfConstantDeclsName =
      HashMap<String, ConstantDeclaration>();

    // 
    Map<String, String> listOfLocalVariableDeclsName =
      HashMap<String, String>();
    
    Map<String, MethodDeclaration> listOfMethodDeclsName =
      HashMap<String, MethodDeclaration>();

    Map<String, ConstructorDeclaration> listOfConstructorDeclsName =
      HashMap<String, ConstructorDeclaration>();

    var i = 0;
    var classBodyElement = classBody.value[i];

    // Walk through all of the class body's contents
    while (i < classBody.value.length - 1) {
      // Constant Declaration DONE
      if (classBodyElement is ConstantDeclaration) {
        // Put the name of ConstantDecl into map, throws exception on duplicate
        // We can't have duplicate Constants
        // value[1] because that's the identifier of the constant declaration
        if (!listOfConstantDeclsName.containsKey(classBodyElement.value[1].value)) {
          // value[3] becuase that's the Expression object (value) of the const expression
          listOfConstantDeclsName[classBodyElement.value[1].value] = classBodyElement.value[3];
        } else {
          throw IllTypedException('''Duplicate constant declaration name: ${classBodyElement.value[1].value},
                                      in class: ${className}''');
        }

        if (!listOfLocalVariableDeclsName.containsKey(classBodyElement.value[1].value)) {
          // value[3] becuase that's the Expression object (value) of the const expression
          listOfConstantDeclsName[classBodyElement.value[1].value] = classBodyElement.value[3];
        } else {
          throw IllTypedException('''Duplicate constant declaration name: ${classBodyElement.value[1].value},
                                      in class: ${className}''');
        }


      // Need to work on this
      } else if (classBodyElement is LocalVariableDeclaration) {

        var nameOfLocalVarDecl = classBodyElement.value[1].value[0].value;


        listOfLocalVariableDeclsName[nameOfLocalVarDecl] = classBodyElement.value[i];
        // typecheckLocalVariableDeclaration(classBodyElement.value[i], );



      // Need to work on this
      } else if (classBodyElement is MethodDeclaration) {

        // Um we don't have a type class (we do but SHHHH) or a Name class so just strings
        if(!listOfMethodDeclsName.containsKey(classBodyElement.value[1].value)) {
          listOfMethodDeclsName[classBodyElement.value[i].value] = classBodyElement.value[i];
          // typecheckMethodDeclaration(classBodyElement.value[i]);
        } else {
          throw IllTypedException('Duplicate method in class: $className');
        }


      } else if (classBodyElement is ConstructorDeclaration) {

        // Um we don't have a type class (we do but SHHHH) or a Name class so just strings
        Map<String, String> gamma = HashMap<String, String>();

        // value[0] is the name of the constructor
        if (!listOfConstructorDeclsName.containsKey(classBodyElement.value[0])) {
          listOfConstructorDeclsName[classBodyElement.value[0].value] = classBodyElement;
          typecheckConstructorDeclaration(classBodyElement.value[i], className);
        } else {
          throw IllTypedException('Duplicate constructors in class: $className');
        }



      }
      i++;
      classBodyElement = classBody.value[i];
    }
  }

  // Not Complete needs work
  Map<String, String> typecheckExpression(
                           final PrimaryNoArrayCreationExpression expression,
                           final Map<String, String> gamma,
                           final String componentName) {
    if (expression.value[0] is PrimaryExpression) {

      gamma.addAll(typecheckPrimaryExpression(expression.value[0], gamma, componentName));

    } else if (expression.value[0] is AssignmentExpression) {

      // gamma.addAll(typecheckAssignmentExpression(expression.value[0]));

    } else if (expression.value[0] is AdditiveExpression) {

      // gamma.addAll(typecheckAdditiveExpression(expression.value[0]));

    } else if (expression.value[0] is MultiplicativeExpression) {

      // gamma.addAll(typecheckMultiplicativeExpression(expression.value[0]));

    } else if (expression.value[0] is EqualitylExpression) {

      // gamma.addAll(typecheckEqualityExpression(expression.value[0]));

    } else if (expression.value[0] is RelationalExpression) {

      // gamma.addAll(typecheckRelationalExpression(expression.value[0]));

    } else if (expression.value[0] is ConditionalAndExpression) {

      // gamma.addAll(typecheckConditionalAndExpression(expression.value[0]));

    } else if (expression.value[0] is ConditionalOrExpression) {

      // gamma.addAll(typecheckConditionalOrExpression(expression.value[0]));

    } else {
      throw IllTypedException('Unrecgonized expression.');
    }
    return gamma;
  }

  Map<String, String> typecheckAdditiveExpression(final AdditiveExpression additiveExpression) {
    var lhs;
    var rhs;
    if (additiveExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(additiveExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized additive expression.');
    }

    if (additiveExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(additiveExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized additive expression.');
    }
  }

  Map<String, String> typecheckMultiplicativeExpression(final MultiplicativeExpression multiplicativeExpression) {
    var lhs;
    var rhs;
    if (multiplicativeExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(multiplicativeExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized multiplicative expression.');
    }

    if (multiplicativeExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(multiplicativeExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized multiplicative expression.');
    }
  }

  Map<String, String> typecheckEqualityExpression(final EqualitylExpression equalityExpression) {
    var lhs;
    var rhs;
    if (equalityExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(equalityExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized equality expression.');
    }

    if (equalityExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(equalityExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized equality expression.');
    }
  }

  Map<String, String> typecheckRelationalExpression(final RelationalExpression relationalExpression) {
    var lhs;
    var rhs;
    if (relationalExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(relationalExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized relational expression.');
    }

    if (relationalExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(relationalExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized relational expression.');
    }
  }

  Map<String, String> typecheckConditionalAndExpression(final ConditionalAndExpression conditionalAndExpression) {
    var lhs;
    var rhs;
    if (conditionalAndExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(conditionalAndExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized logical AND expression.');
    }

    if (conditionalAndExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(conditionalAndExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized logical AND expression.');
    }
  }

  Map<String, String> typecheckConditionalOrExpression(final ConditionalOrExpression conditionalOrExpression) {
    var lhs;
    var rhs;
    if (conditionalOrExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(conditionalOrExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized logical OR expression.');
    }

    if (conditionalOrExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(conditionalOrExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized logical OR expression.');
    }
  }

  // Not complete
  Map<String, String> typecheckPrimaryExpression(final PrimaryExpression primaryExpression,
                                  final Map<String, String> gamma,
                                  final String componentName) {
    if (primaryExpression is Literal) {
      // Need to fix this
      // typecheckLiteral()
    } else if (primaryExpression is ParenthesizedExpression) {
      gamma.addAll( typecheckPrimaryExpression(primaryExpression.value[0], gamma, componentName) );
    } else if (primaryExpression is MemberAccess) {
      gamma.addAll( typecheckMemberAccess(primaryExpression.value[0], gamma, componentName) );
    } else if (primaryExpression is InvocationExpression) {
      // gamma.addAll( typecheckInvocationExpression(primaryExpression.value[0], gamma, componentName) );
    } else if (primaryExpression is ThisAccess) {
      // gamma.addAll( typecheckThisAccess(primaryExpression.value[0], gamma, componentName) );
    } else if (primaryExpression is ObjectCreationExpression) {
      // gamma.addAll( typecheckObjectCreationExpression(primaryExpression.value[0], gamma, componentName) );
    } else if (primaryExpression is TypeOfExpression) {
      // gamma.addAll( typecheckTypeOfExpression(primaryExpression.value[0], gamma, componenetName) );
    } else {
      throw IllTypedException('Unrecognized primary expression.');
    }
    return gamma;
  }

  Map<String, String> typecheckThisAccess(final ThisAccess thisAccess) {
    // should just return 'this' as a string
    return thisAccess.value[0].value;
  }

  // return type needs to be thought out
  void typecheckTypeOfExpression(final TypeOfExpression typeOfExpression) {
    // compare to thing in map probably
    return;
  }

  Map<String, String> typecheckMemberAccess(final MemberAccess memberAccess,
                             final Map<String, String> gamma,
                             final String componentName) {
    if (memberAccess.value[0] is PrimaryExpression) {
      gamma.addAll( typecheckPrimaryExpression(memberAccess.value[0], gamma, componentName) );
    } else if (memberAccess.value[0] is Type) {
      // gamma[] = typecheckType(memberAccess.value[0]);
    } else {
      throw IllTypedException('Unrecognized member access.');
    }
    return gamma;
  }

  // Done
  String typecheckType(final Type type) {
    if (type.value[0] is ValueType) {
      return typecheckValueType(type.value[0]);
    } else if (type.value[0] is ReferenceType) {
      return typecheckReferenceType(type.value[0]);
    } else {
      throw IllTypedException('Unrecognized type.');
    }
  }

  // Done
  String typecheckReferenceType(final ReferenceType referenceType) {
    if (referenceType.value[0].value == 'object') {
      return referenceType.value[0].value;
    } else if (referenceType.value[0].value == 'string') {
      return referenceType.value[0].value;
    } else if (referenceType.value[0] is IdentifierToken) {
      return referenceType.value[0].value;
    } else {
      throw IllTypedException('Unrecognized reference type.');
    }
  }

  // Done
  String typecheckValueType(final ValueType valueType) {

    if (valueType.value[0].value == 'bool') {

      return valueType.value[0].value;

    } else if (valueType.value[0].value == 'decimal') {

      return valueType.value[0].value;

    } else if (valueType.value[0] is IntegralType) {

      return typecheckIntegralType(valueType.value[0]);

    } else if (valueType.value[0] is FloatingPointType) {

      return typecheckFloatingPointType(valueType.value[0]);

    } else {
      throw IllTypedException('Unrecognized value type.');
    }
  }

  // Done
  // terminal leaf FINALLY
  String typecheckIntegralType(final IntegralType integralType) {
    return integralType.value[0].value;
  }

  // Done
  // terminal leaf FINALLY
  String typecheckFloatingPointType(final FloatingPointType floatingPointType) {
    return floatingPointType.value[0].value;
  }

  // If a method doesn't take a gamma it's a new scope
  void typecheckMethodDeclaration(final MethodDeclaration methodDeclaration,
                                  final Map<String, String> gamma) {

    Map<String, String> gamma = HashMap<String, String>();
    String methodName = methodDeclaration.value[1].value;
    var methodReturnType;

    // figure out return statement type
    if (methodDeclaration.value[0].value == 'void') {
      methodReturnType = methodDeclaration.value[0]; // void Token
    } else if (methodDeclaration.value[0] is Type) {
      methodReturnType = typecheckType(methodDeclaration.value[0]); // Should grab type token
    } else {
      throw IllTypedException('Unrecognized return type.');
    }

    // Start at 3 becuase the first three are return type, method name, then {
    var i = 3;
    while (methodDeclaration.value[i] is FixedParam) {
      try {
        gamma.addAll( typecheckFixedParam(methodDeclaration.value[i], gamma, methodName) );
      } on IllTypedException {
        throw IllTypedException('Incorrect fixed params in method.');
      }
      i++;
    }

    gamma.addAll(typecheckBlockStatement(methodDeclaration.value[i + 2], gamma, methodName));

    return;
  }

  // Done
  // Local Variable Declaration
  Map<String, String> typecheckLocalVariableDeclaration(
                                         final LocalVariableDeclaration localVariableDecl,
                                         final Map<String, String> gamma,
                                         final String componentName) {
    var localVarDeclType;

    if (localVariableDecl.value[0] is LocalVariableType) {
      localVarDeclType = typecheckLocalVariableType(localVariableDecl.value[0]);
    } else {
      throw IllTypedException('Unrecognized local variable type.');
    }

    if (localVariableDecl.value[1] is LocalVariableDeclaration) {
      // gamma.addAll( typecheckLocalVariableDeclarator(localVariableDecl.value[1], gamma, componentName, typeOfDecl) );
    } else {
      throw IllTypedException('Unrecognized local variable declaration');
    }
    return gamma;
  }

  String typecheckLocalVariableType(final LocalVariableType localVariableType) {
    return typecheckType(localVariableType.value[0]);
  }

  // Done
  // Declarator without an S
  Map<String, String> typecheckLocalVariableDeclarator(
                                        final LocalVariableDeclarator localVariableDeclarator,
                                        final Map<String, String> gamma,
                                        final String componentName,
                                        final String typeOfDecl) {
    
    if (!gamma.containsKey(localVariableDeclarator.value[0].value)) {
      gamma[localVariableDeclarator.value[0].value] = typeOfDecl;
    } else {
      throw IllTypedException('The variable: ${localVariableDeclarator.value[0].value} has already been declared.');
    }

    if (localVariableDeclarator.value[2] is LocalVariableInitializer) {
      gamma.addAll( typecheckLocalVariableInitializer(localVariableDeclarator.value[2], gamma, componentName, typeOfDecl) );
    } else {
      throw IllTypedException('Unrecognized local variable declarator.');
    }
    return gamma;
  }

  // Done
  Map<String, String> typecheckLocalVariableInitializer(
                                         final LocalVariableInitializer localVariableInitializer,
                                         final Map<String, String> gamma,
                                         final String componentName,
                                         final String typeOfDecl) {
    if (localVariableInitializer.value[0] is PrimaryNoArrayCreationExpression) {
      gamma.addAll( typecheckExpression(localVariableInitializer.value[0], gamma, componentName) );
    } else {
      throw IllTypedException('Unrecognized local variable initializer.');
    }
    return gamma;
  }

  String getLocalVariableDeclaratorName(final LocalVariableDeclarator localVariableDeclarator) {
    return localVariableDeclarator.value[0].value;
  }

  // typecheckConstructorDeclaration
  void typecheckConstructorDeclaration(final ConstructorDeclaration constructorDeclaration,
                                        final String className) {
    Map<String, String> gamma = HashMap<String, String>();
    if (constructorDeclaration.value[0].value == className) {
      typecheckFixedParam(constructorDeclaration.value[2], gamma, 'constructor + $className');
      // typecheckBlockStatement(constructorDeclaration.value[4]);
    } else {
      throw IllTypedException('''Constructor ${constructorDeclaration.value[0].value}
                              does not match classname: $className''');
    }
  }

  // Done
  Map<String, String> typecheckFixedParam(final FixedParam fixedParam,
                                          final Map<String, String> gamma,
                                          final String componentName) {
    var paramType = typecheckType(fixedParam.value[0]);
    var paramName = fixedParam.value[1].value;

    if (!gamma.containsKey(paramName)) {
      gamma[paramName] = paramType;
    } else {
      throw IllTypedException('Duplicate parameters in list: $componentName');
    }

    return gamma;
  }

  // Done
  Map<String, String> typecheckBlockStatement(final Block block,
                                              final Map<String, String> gamma,
                                              final String componentName) {
    // Start at 1 not zero because first thing in block list is a { token
    var i = 1;
    // Minus - 2 becuase the last thing in block list is a } token
    // Normally the index tranversal is length - 1 but we want to ignore last
    while (i < block.value.length - 2) {
      if (block.value[i] is Statement) {
        gamma.addAll( typecheckStatements(block.value[i], gamma, componentName) );
      } else {
        throw IllTypedException('Unrecognized statement in block.');
      }
      i++;
    }
    return gamma;
  }

  // Not Finished Go Back
  Map<String, String> typecheckStatements(final Statement statement,
                                          final Map<String, String> gamma,
                                          final String componentName) {
    if (statement is DeclarationStatement) {
      // gamma.addAll( typecheckDeclarationStatement(statement.value[0]), gamma, componentName );
    } else if (statement is EmbeddedStatement) {
      // gamma.addAll( typecheckEmbeddedStatement(statement.value[0]), gamma, componentName );
    } else {
      throw IllTypedException('Unrecognized statement.');
    }

    return gamma;
  }

  // Not Finished Go Back
  Map<String, String> typecheckDeclarationStatement(final DeclarationStatement declarationStatement,
                                     final Map<String, String> gamma,
                                     final String componentName) {
    if (declarationStatement is LocalVariableDeclaration) {
      gamma.addAll( typecheckLocalVariableDeclaration(declarationStatement.value[0], gamma, componentName) );
    } else if (declarationStatement is ConstantDeclaration) {
      // gamma.addAll( typecheckConstantDeclaration(declarationStatement.value[0], gamma, componentName) );
    } else {
      throw IllTypedException('Unrecognized declaration statement.');
    }

    return gamma;
  }

  void typecheckConstantDeclaration(final ConstantDeclaration constantDeclaration) {
    if (constantDeclaration.value[3] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(constantDeclaration.value[3]);
    } else {
      throw IllTypedException('');
    }
  }

  void typecheckEmbeddedStatement(final EmbeddedStatement embeddedStatement) {
    if (embeddedStatement is Block) {
      // typecheckBlockStatement(embeddedStatement.value[0]);
    } else if (embeddedStatement is EmptyStatement) {
      // Do nothing
      // no reason to check an empty statement of its non existant type
      return;
    } else if (embeddedStatement is ExpressionStatement) {
      typecheckExpressionStatement(embeddedStatement.value[0]);
    } else if (embeddedStatement is IterationStatement) {
      typecheckIterationStatement(embeddedStatement.value[0]);
    } else if (embeddedStatement is JumpStatement) {
      typecheckJumpStatement(embeddedStatement.value[0]);
    } else if (embeddedStatement is SelectionStatement) {
      typecheckSelectionStatement(embeddedStatement.value[0]);
    } else {
      throw IllTypedException('Unrecognized statement.');
    }
  }

  void typecheckExpressionStatement(final ExpressionStatement expressionStatement) {
    // This is broken go back later
    if (expressionStatement is InvocationExpression) {
      // typecheckInvocationExpression(expressionStatement.value[0]);
    } else if (expressionStatement is ObjectCreationExpression) {
      // typecheckObjectCreationExpression(expressionStatement.value[0]);
    } else if (expressionStatement is AssignmentExpression) {
      typecheckAssignmentExpression(expressionStatement.value[0]);
    } else {
      throw IllTypedException('Unrecognized expression statement.');
    }
  }

  // This is broken go back later
  // void typecheckInvocationExpression(final InvocationExpression invocationExpression) {

  // }

  // This is broken go back later
  // void typecheckObjectCreationExpression(final ObjectCreationExpression objectCreationExpression) {

  // }

  // This is broken go back later
  void typecheckAssignmentExpression(final AssignmentExpression assignmentExpression) {
    var typeLHS, typeRHS;
    if (assignmentExpression.value[0] is PrimaryNoArrayCreationExpression) {
      // broken
      typeLHS = 0;
      // typecheckExpression(assignmentExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized expression.');
    }

    if (assignmentExpression.value[2] is PrimaryNoArrayCreationExpression) {
      // broken
      typeRHS = 0;
      // typecheckExpression(assignmentExpression.value[2]);
    } else {
      throw IllTypedException('Unrecognized expression.');
    }
  }

  void typecheckIterationStatement(final IterationStatement iterationStatement) {
    if (iterationStatement is ForStatement) {
      typecheckForStatement(iterationStatement.value[0]);
    } else if (iterationStatement is WhileStatement) {
      typecheckWhileStatement(iterationStatement.value[0]);
    } else {
      throw IllTypedException('Unrecognized iteration statement.');
    }
  }

  // for statement is basically a block with it's own scope
  // need maps for typechecking in here
  void typecheckForStatement(final ForStatement forStatement) {
    if (forStatement.value[2] is LocalVariableDeclaration) {
      // typecheckLocalVariableDeclaration(forStatement.value[2]);
    } else if (forStatement.value[2] is ExpressionStatement) {
      typecheckExpressionStatement(forStatement.value[2]);
    } else {
      throw IllTypedException('Unrecognized for loop intializer.');
    }
    // Broken right now go back later
    if (forStatement.value[4] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(forStatement.value[4]);
    } else {
      throw IllTypedException('Unrecognized for loop guard');
    }

    if (forStatement.value[6] is ExpressionStatement) {
      typecheckExpressionStatement(forStatement.value[6]);
    } else {
      throw IllTypedException('Unrecognized for loop incrementor.');
    }

    if (forStatement.value[8] is EmbeddedStatement) {
      typecheckEmbeddedStatement(forStatement.value[8]);
    } else {
      throw IllTypedException('Unrecognized embedded statement in for loop.');
    }
  }

  // Need a map for a while statement basically a whole new scope
  void typecheckWhileStatement(final WhileStatement whileStatement) {
    // Broken right now go back later
    if (whileStatement.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(whileStatement.value[2]);
    } else {
      throw IllTypedException('Unrecognized conditional in while loop.');
    }

    if (whileStatement.value[4] is EmbeddedStatement) {
      typecheckEmbeddedStatement(whileStatement.value[4]);
    }
  }

  void typecheckJumpStatement(final JumpStatement jumpStatement) {
    // Go back to this
    if (jumpStatement.value[1] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(jumpStatement.value[1]);
    } else {
      throw IllTypedException('Unrecognized jump statement.');
    }
  }

  void typecheckSelectionStatement(final SelectionStatement selectionStatement) {
    // Go back to this
    if (selectionStatement.value[2] is PrimaryNoArrayCreationExpression) {
      // typecheckExpression(selectionStatement.value[2], ga);
    } else {
      throw IllTypedException('Unrecognized conditional in if statement.');
    }

    if (selectionStatement.value[4] is EmbeddedStatement) {
      typecheckEmbeddedStatement(selectionStatement.value[4]);
    } else {
      throw IllTypedException('Unrecognized embedded statement under if\'s true branch.');
    }

    if (selectionStatement.value[6] is EmbeddedStatement) {
      typecheckEmbeddedStatement(selectionStatement.value[6]);
    } else {
      throw IllTypedException('Unrecognized embedded statement under if\'s false branch.');
    }
  }

}
