import 'dart:collection';

import 'package:cs2dart/src/classes/variants/ClassBase.dart';
import 'package:cs2dart/src/classes/variants/ClassBody.dart';
import 'package:cs2dart/src/classes/variants/variants/ConstructorDeclaration.dart';
import 'package:cs2dart/src/classes/variants/variants/MethodDeclaration.dart';
import 'package:cs2dart/src/interfaces/variants/InterfaceDeclaration.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/statements/variants/DeclarationStatementVariants/constant_declaration.dart';
import 'package:cs2dart/src/typechecker/ill_typed_expection.dart';
import 'package:cs2dart/statement.dart';

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

  // Typechecks the class declaration 
  void typecheckClassDeclaration(final ClassDeclaration classDec) {
    if (classDec.value[2].runtimeType == ClassBase) {
      // This should be a classBody
      typecheckClassBody(classDec.value[3], classDec.value[1].value);
    } else if (classDec.value[2].runtimeType == ClassBody) {
      // This should be a classBody
      typecheckClassBody(classDec.value[2], classDec.value[1].value);
    } else {
      throw IllTypedException('Invalid ClassBody');
    }
  }

  void typecheckClassBody(final ClassBody classBody, final String className) {
    
    Map<String, ConstantDeclaration> listOfConstantDecls = 
      HashMap<String, ConstantDeclaration>();
    Map<String, LocalVariableDeclaration> listOfLocalVariableDecls = 
      HashMap<String, LocalVariableDeclaration>();
    Map<String, MethodDeclaration> listOfMethodDecls = 
      HashMap<String, MethodDeclaration>();
    Map<String, ConstructorDeclaration> listOfConstructorDecls = 
      HashMap<String, ConstructorDeclaration>();

    var startingPos = 2;
    var classBodyElement = classBody.value[startingPos];
    while ((classBodyElement is ConstantDeclaration) ||
            classBodyElement is LocalVariableDeclaration ||
            classBodyElement is MethodDeclaration ||
            classBodyElement is ConstantDeclaration) {
              if (classBodyElement is ConstantDeclaration) {
                if (!listOfConstantDecls.containsKey(classBodyElement.value[1].value)) {
                  // Put the name of ConstantDecl into map, throws exception on duplicate
                  // We can't have duplicate Constants
                  listOfConstantDecls[classBodyElement.value[1].value] = typecheckExpression(classBodyElement.value[3]);
                } else {
                  throw IllTypedException('Duplicate constant declaration name: ' + classBodyElement.value[1].value);
                }
              } else if (classBodyElement is LocalVariableDeclaration) {

              } else if (classBodyElement is MethodDeclaration) {
                
              } else if (classBodyElement is ConstructorDeclaration) {
                if (!listOfConstructorDecls.containsKey(classBodyElement.value[classBody]) 
                  listOfConstructorDecls[] = typecheckConstructorDeclarator();
              }

    }
  }

  typecheckExpression(final ExpressionStatement expressionStmt) {

  }

}
