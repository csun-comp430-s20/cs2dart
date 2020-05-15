import 'dart:collection';

import 'package:cs2dart/src/interfaces/variants/InterfaceDeclaration.dart';
import 'package:cs2dart/src/classes/variants/ClassDeclaration.dart';
import 'package:cs2dart/src/namespaces/namespace.dart';
import 'package:cs2dart/src/typechecker/ill_typed_expection.dart';

// Hypothetical imports for the syntax above and below

class Typechecker {

  // String is in place of recording the TypeDeclaration's name as the Map's key
  // TypeDeclaration is the value of the Map, actual TypeDeclaration objects
  Map<String, ClassDeclaration> _classDeclarations;

  // Constructor for the typechecker, get all of the high level typedeclarations
  Typechecker(final Namespace namespace) {
    _classDeclarations = HashMap<String, ClassDeclaration>();
    for (ClassDeclaration classDec in namespace.value) {
      if (!_classDeclarations.containsKey(classDec.value[0])) {
        _classDeclarations[classDec.value[0]] = classDec;
      } else {
        throw IllTypedException('Duplicate type declaration name: ' + classDec.value[0]);
      }
    }
  } // Typechecker

  // Typechecks the namespace's contents which should be classDeclarations
  void typecheckNamespace(final Namespace namespace) {

    for (ClassDeclaration classDec in namespace.value) {
      typecheckClassDeclaration(classDec);
    }
  } // typecheckNamespace

  // Typechecks the type declaration 
  void typecheckClassDeclaration(final ClassDeclaration classDec) {
    typecheckClassDeclaration();
  }

}
