import 'dart:collection';
import 'dart:html';

import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/variants/ConstructorDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/variants/FixedParam.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/assignment_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/invocation_expression.dart';
import 'package:cs2dart/src/expressions/variants/PrimaryNoArrayCreationExpressionVariants/object_creation_expression.dart';
import 'package:cs2dart/src/interfaces/variants/InterfaceDeclaration.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/typechecker/ill_typed_expection.dart';
import 'package:cs2dart/statement.dart';
import 'package:cs2dart/tokens.dart';

// Hypothetical imports for the syntax above and below

// Classes are verified by name through constructor
//

class Typechecker {

  // String is in place of recording the TypeDeclaration's name as the Map's key
  // TypeDeclaration is the value of the Map, actual TypeDeclaration objects
  Map<String, ClassDeclaration> _classDeclarations;

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

  // Basically the main
  // Typechecks the namespace's contents which should be classDeclarations
  void typecheckNamespace(final Namespace namespace) {
    for (ClassDeclaration classDec in namespace.value) {
      typecheckClassDeclaration(classDec);
    }
  } // typecheckNamespace

  // Typechecks the class declarations from a namespace object
  void typecheckClassDeclaration(final ClassDeclaration classDec) {
    var i = 0;
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
      // The extends is valid
      return;
    } else {
      throw IllTypedException('Class ' + className +
        'extends non-existant class: + classBase.value[0].value');
    }
  }

  // Typecheckes the class body objects
  void typecheckClassBody(final ClassBody classBody, final String className) {

    Map<String, ConstantDeclaration> listOfConstantDeclsName =
      HashMap<String, ConstantDeclaration>();
    Map<String, LocalVariableDeclaration> listOfLocalVariableDeclsName =
      HashMap<String, LocalVariableDeclaration>();
    Map<String, MethodDeclaration> listOfMethodDeclsName =
      HashMap<String, MethodDeclaration>();
    Map<String, ConstructorDeclaration> listOfConstructorDeclsName =
      HashMap<String, ConstructorDeclaration>();

    var i = 0;
    var classBodyElement = classBody.value[i];

    // Walk through all of the class body's contents
    while (i < classBody.value.length - 1) {
      // Constant Declaration done (FOR NOW)
      if (classBodyElement is ConstantDeclaration) {
        // Put the name of ConstantDecl into map, throws exception on duplicate
        // We can't have duplicate Constants
        if (!listOfConstantDeclsName.containsKey(classBodyElement.value[1].value)) {
          // value[3] becuase that's the Expression object (value) of the const expression
          listOfConstantDeclsName[classBodyElement.value[1].value] = classBodyElement.value[3];
        } else {
          throw IllTypedException('Duplicate constant declaration name: ${classBodyElement.value[1].value}');
        }

      } else if (classBodyElement is LocalVariableDeclaration) {
        listOfLocalVariableDeclsName[getLocalVariableDeclaratorName(classBodyElement.value[1])]
          = classBodyElement;
        typecheckLocalVariableDeclaration(classBodyElement);



      } else if (classBodyElement is MethodDeclaration) {
        listOfMethodDeclsName[classBodyElement.value[1].value] = typecheckMethodDeclaration();

      } else if (classBodyElement is ConstructorDeclaration) {
        // value[0] is the name of the constructor
        if (!listOfConstructorDeclsName.containsKey(classBodyElement.value[0])) {
          listOfConstructorDeclsName[classBodyElement.value[0].value] = classBodyElement;
          typecheckConstructorDeclaration(classBodyElement, className);
        } else {
          throw IllTypedException('Duplicate constructors in class: $className');
        }
      }
      i++;
    }
  }

  // its broken need to wait on this
  void typecheckExpression(final ExpressionStatement expressionStmt) {

  }

  typecheckMethodDeclaration(final MethodDeclaration methodDeclaration) {

    var methodReturnType;

    if (methodDeclaration.value[0].value == 'void') {
      methodReturnType = methodDeclaration.value[0]; // void Token
    } else if (methodDeclaration.value[0] is Type) {
      methodReturnType = getType(methodDeclaration.value[0]); // Should grab type token
    } else {
      throw IllTypedException('Unrecognized type.');
    }




    var actualReturnType = getType();

  }

  getType(final Type type) {

  }

  // Local Variable Declaration
  void typecheckLocalVariableDeclaration(final LocalVariableDeclaration localVariableDecl) {
    typecheckLocalVariableDeclarators(localVariableDecl.value[1]);
  }

  // Declarators with an S
  void typecheckLocalVariableDeclarators(final LocalVariableDeclarators localVariableDeclarators) {
    typecheckLocalVariableDeclarator(localVariableDeclarators.value[0]);
  }

  // Declarator without an S
  void typecheckLocalVariableDeclarator(final LocalVariableDeclarator localVariableDeclarator) {

  }

  String getLocalVariableDeclaratorName(final LocalVariableDeclarator localVariableDeclarator) {
    return localVariableDeclarator.value[0].value;
  }

  // typecheckConstructorDeclaration
  void typecheckConstructorDeclaration(final ConstructorDeclaration constructorDeclaration,
                                        final String className) {
    if (constructorDeclaration.value[0].value == className) {
      typecheckFixedParam(constructorDeclaration.value[2]);
      typecheckBlockStatement(constructorDeclaration.value[4]);
    } else {
      throw IllTypedException('''Constructor ${constructorDeclaration.value[0].value}
                              does not match classname: $className''');
    }
  }

  void typecheckFixedParam(final FixedParam fixedParam) {

  }

  void typecheckBlockStatement(final Block block) {
    // Start at 1 not zero because first thing in block list is a { token
    var i = 1;
    // Minus - 2 becuase the last thing in block list is a } token
    while (i < block.value.length - 2) {
      if (block.value[i] is Statement) {
        typecheckStatements(block.value[i]);
      } else {
        throw IllTypedException('Unrecognized statement in block.');
      }
    }
  }

  void typecheckStatements(final Statement statement) {
    if (statement is DeclarationStatement) {
      typecheckDeclarationStatement(statement.value[0]);
    } else if (statement is EmbeddedStatement) {
      typecheckEmbeddedStatement(statement.value[0]);
    }
  }

  void typecheckDeclarationStatement(final DeclarationStatement declarationStatement) {
    if (declarationStatement is LocalVariableDeclaration) {
      typecheckLocalVariableDeclaration(declarationStatement.value[0]);
    } else if (declarationStatement is ConstantDeclaration) {
      typecheckConstantDeclaration(declarationStatement.value[0]);
    }
  }

  void typecheckConstantDeclaration(final ConstantDeclaration constantDeclaration) {
    if (constantDeclaration.value[3] is Expression) {
      typecheckExpression();
    } else {
      throw IllTypedException('');
    }
  }

  void typecheckEmbeddedStatement(final EmbeddedStatement embeddedStatement) {
    if (embeddedStatement is Block) {
      typecheckBlockStatement(embeddedStatement.value[0]);
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
      typecheckInvocationExpression(expressionStatement.value[0]);
    } else if (expressionStatement is ObjectCreationExpression) {
      typecheckObjectCreationExpression(expressionStatement.value[0]);
    } else if (expressionStatement is AssignmentExpression) {
      typecheckAssignmentExpression(expressionStatement.value[0]);
    } else {
      throw IllTypedException('Unrecognized expression statement.');
    }
  }

  // This is broken go back later
  void typecheckInvocationExpression(final InvocationExpression invocationExpression) {

  }

  // This is broken go back later
  void typecheckObjectCreationExpression(final ObjectCreationExpression objectCreationExpression) {

  }

  // This is broken go back later
  void typecheckAssignmentExpression(final AssignmentExpression assignmentExpression) {
    var typeLHS, typeRHS;
    if (assignmentExpression.value[0] is Expression) {
      // broken
      typeLHS = typecheckExpression(assignmentExpression.value[0]);
    } else {
      throw IllTypedException('Unrecognized expression.');
    }

    if (assignmentExpression.value[2] is Expression) {
      // broken
      typeRHS = typecheckExpression(assignmentExpression.value[2]);
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
      typecheckLocalVariableDeclaration(forStatement.value[2]);
    } else if (forStatement.value[2] is ExpressionStatement) {
      typecheckExpressionStatement(forStatement.value[2]);
    } else {
      throw IllTypedException('Unrecognized for loop intializer.');
    }
    // Broken right now go back later
    if (forStatement.value[4] is Expression) {

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
    if (whileStatement.value[2] is Expression) {

    } else {
      throw IllTypedException('Unrecognized conditional in while loop.');
    }

    if (whileStatement.value[4] is EmbeddedStatement) {
      typecheckEmbeddedStatement(whileStatement.value[4]);
    }
  }

  void typecheckJumpStatement(final JumpStatement jumpStatement) {
    // Go back to this
    if (true) {
      //typecheckExpression();
    } else {
      throw IllTypedException('');
    }
  }

  void typecheckSelectionStatement(final SelectionStatement selectionStatement) {
    // Go back to this
    if (selectionStatement.value[2] is Expression) {

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
