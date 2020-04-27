import 'package:cs2dart/tokens.dart';
import 'parser_node.dart';
import 'dart:io';

//Abstract syntax tree
//no switch stmt
class AST {

  // stmtType

  ParseNode _head; // = null;
  //ParseNode _root; // = null;
  ParseNode _tmp1; // = null;
  ParseNode _tmp2; // = null;
  ParseNode _tmp3; // = null;


  AST();

  void insert(ParseNode inputNode)
  {
    insertA(_head, inputNode);
  }

  void insertA(ParseNode curr, ParseNode inputNode)
  {
    final newNode = inputNode;
    //this will be the function that decides stuff and makes tree.
    if (curr == null)
    {
      if (_head == null)
      {
        _head = newNode;
      }
      curr = newNode;
      return;
    }
    else
    {
      if (newNode.token.value == ';')
      {
        curr = newNode;
        return;
      }
      else
      {
        insertB(curr, newNode);
        return;
      }
    }

  }

  void insertB(ParseNode curr2, ParseNode inputNode)
  {
      //starts branching of statement
    //If token is an identifier
    if (inputNode.token is IdentifierToken)
    {
      if (curr2.token is IdentifierToken)
      {
        curr2.rightToken = inputNode;
        return;
      }
      else
      {
        //If token was preceded by an op or punc (declaration)
        if (curr2.token is OperatorOrPunctuatorToken) //need to change to boolean, int, etc.
        {
          if (curr2.leftToken == null)
          {
            curr2.leftToken = inputNode;
            return;
          }
          else
          {
            curr2.rightToken = inputNode;
            return;
          }
        }
        else
        {
          curr2.leftToken = inputNode;
          inputNode.parent = curr2;
          return;
        }
      }
    }
    //If token is an op or punc
    else if (inputNode.token is OperatorOrPunctuatorToken)
    {
      if (curr2.rightToken != null)
      {
        insertB(curr2.rightToken, inputNode);
        return;
      }
      if (inputNode.token.value == ';')
      {
        curr2.rightToken = inputNode;
        return;
      }
      else
      {
        if (curr2.token is IntegerLiteralToken)
        {

          //swap (never with left token)
          // _tmp1 = curr2;
          curr2.parent.rightToken = inputNode;
          inputNode.leftToken = curr2;
        }
        else
        {
          inputNode.leftToken = curr2;
          _head = inputNode; //no new parent then...
          return;
        }
      }

    }
    else if (inputNode.token is IntegerLiteralToken)
    {
      if (curr2.token is OperatorOrPunctuatorToken) //need PANDAS??
      {
        if (curr2.leftToken != null)
        {
          if (curr2.rightToken == null)
          {
            curr2.rightToken = inputNode;
            inputNode.parent = curr2;
            return;
          }
          else
          {
            insertB(curr2.rightToken, inputNode);
          }
        }
        else
        {
          curr2.leftToken = inputNode;
          inputNode.parent = curr2;
          return;
        }
      }
    }
    else if (inputNode.token is RealLiteralToken)
    {
      if (curr2.token is OperatorOrPunctuatorToken) //need PEMDAS??
      {
        if (curr2.leftToken != null)
        {
          curr2.leftToken = inputNode;
          return;
        }
        else
        {
          curr2.rightToken = inputNode;
          return;
        }
      }
      else
      {

      }
    }
    else if (inputNode.token is KeywordToken)
    {
      if (inputNode.token.value == 'while')
      {
        insertB(curr2, inputNode);
        return;
      }
      if (inputNode.token.value == 'int')
      {
        insertB(curr2, inputNode);
      }
    }
    else if (inputNode.token is StringLiteralToken)
    {
      if (curr2.token is StringLiteralToken) //need to change to boolean, int, etc.
      {
        curr2.rightToken = inputNode;
        return;
      }
      else
      {
        if (curr2.token is OperatorOrPunctuatorToken)
        {
          if (curr2.leftToken == null)
          {
            curr2.leftToken = inputNode;
            return;
          }
          else
          {
            curr2.rightToken = inputNode;
            return;
          }
        }
        else
        {
          curr2.rightToken = inputNode;
          return;
        }
      }
    }
    return;
  }
  final int cntr = 10;

  @override
  ParseNode get head {
    return _head;
  }
  void printTreeB(ParseNode base, int it)
  {
    if (base == null)
    {
      return;
    }
    it += cntr;
    printTreeB(base.rightToken, it);

    stdout.write('\n');
    for (int c = cntr; c < it; c++)
    {
      stdout.write(" ");
    }
    stdout.write('${base.token.value}\n');
    printTreeB(base.leftToken, it);
  }
  void printTree(int i)
  {
    if (i == 1){
      printPreOrderTraversal(_head);
    }
    else{
    printTreeB(_head, 0);
    }
  }

  void printPreOrderTraversal(ParseNode start){
    if (start == null){
      return;
    }
    stdout.write('${start.token.value}');

    if (start.leftToken != null){
      stdout.write('left');
      printPreOrderTraversal(start.leftToken);
    }
    if (start.rightToken != null){
      stdout.write('right');
      printPreOrderTraversal(start.rightToken);
    }
  }
}
