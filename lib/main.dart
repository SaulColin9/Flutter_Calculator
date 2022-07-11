import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
 ));
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Calculadora(),
      ),
      
    ); 
  }
}


class Calculadora extends StatefulWidget {
  
  @override
  State<Calculadora> createState() => _CalculadoraState();
}

enum Operation {Sum, Mult, Sub, Equals}

class _CalculadoraState extends State<Calculadora> {

  static double height = 0;
  static double width = 0;
  static double a = 0;
  static double b = 0;
  static String displayedNumbers = "";
  double buttonWidth = 0;
  double buttonHeight = 0;

  Operation operationState = Operation.Equals;

  void setStateCalc(){
    setState(() {
      
    });
  }



  @override
  Widget build(BuildContext context) {
    width = MediaQuery. of(context). size. width ;
    height = MediaQuery. of(context). size. height;
    buttonHeight = (height - 100)/4;
    buttonWidth = width/4;
    return Container(
      child: Column(
        children: <Widget>[
          Row(        //Esta fila va a contener el textfield de la pantalla
            children: <Widget>[
              Container(
                height: 100,
                width: width,
                child: Text(displayedNumbers,
                 style: TextStyle(
                    fontSize: 54
                  ),
                )
              ),
              
              
            ],
          ),
          Row(
            //Fila con numeros 1 , 2 y 3
            children: <Widget>[
              NumberButton("1", (){
                setState(() {
                  displayedNumbers+= "1";

                });
              }),
              NumberButton("2", (){
                setState(() {
                  displayedNumbers += "2";
                });
              }),
              NumberButton("3", (){
                setState(() {
                  displayedNumbers += "3";
                });
              }),
              SizedBox(//Multiplication button
              width: buttonWidth,
              height: buttonHeight,
            
              child: TextButton(
                onPressed: (() => operationButton(Operation.Mult)),
                child: ButtonSymbol("X"),
                style: OperationButtonStyle.getOperationButtonStyle(),
          ),
    ),
            ],
          ),
          Row(
            //Fila con numeros 4 , 5 y 6
            children: <Widget>[
              NumberButton("4", (){
                setState(() {
                  displayedNumbers+= "4";

                });
              }),
              NumberButton("5", (){
                setState(() {
                  displayedNumbers += "5";
                });
              }),
              NumberButton("6", (){
                setState(() {
                  displayedNumbers += "6";
                });
              }),
              SizedBox(//Substraction button
                width: buttonWidth,
                height: buttonHeight,
              
                child: TextButton(
                  onPressed: (() => operationButton(Operation.Sub)),
                  child: ButtonSymbol("-"),
                  style: OperationButtonStyle.getOperationButtonStyle(),
          ),
    ),
            ],
          ),
          Row(
            //Fila con numeros 7 , 8 y 9
            children: <Widget>[
              NumberButton("7", (){
                setState(() {
                  displayedNumbers+= "7";

                });
              }),
              NumberButton("8", (){
                setState(() {
                  displayedNumbers += "8";
                });
              }),
              NumberButton("9", (){
                setState(() {
                  displayedNumbers += "9";
                });
              }),

              SizedBox(//Addition button
              width: buttonWidth,
              height: buttonHeight,
            
              child: TextButton(
                onPressed: (() => operationButton(Operation.Sum)),
                child: ButtonSymbol("+"),
                style: OperationButtonStyle.getOperationButtonStyle(),
          ),
    ),
            ],
          ),
          Row(
            children: <Widget>[
                NumberButton("0", (){
                setState(() {
                  displayedNumbers += "0";
                });
              }),
                NumberButton(".", (){
                setState(() {
                  displayedNumbers += ".";
                });
              }),

              SizedBox(//Delete button
              width: buttonWidth,
              height: buttonHeight,
            
              child: TextButton(
                onPressed: deleteButton,
                child: ButtonSymbol("<="),
                style: OperationButtonStyle.getOperationButtonStyle(),
            ),
          ),
              SizedBox(//Equals button
              width: buttonWidth,
              height: buttonHeight,
            
              child: TextButton(
                onPressed: equalsButton,
                child: ButtonSymbol("="),
                style: OperationButtonStyle.getOperationButtonStyle(),
          ),
    ),

            ],
          ),
        ],
      ),
    );
    
  }


  void deleteButton(){
    setState(() {
      if(!displayedNumbers.isEmpty){
        displayedNumbers = displayedNumbers.substring(0, displayedNumbers.length - 1);
      }
    });
  }

  void equalsButton(){

    setState(() {
      if(displayedNumbers.isNotEmpty){
        
        switch (operationState) {
        case Operation.Sum:
          //Suma
          displayedNumbers = (a + double.parse(displayedNumbers)).toString();
           break;

        case Operation.Mult:
           //Multiplicacion
           displayedNumbers = (a * double.parse(displayedNumbers)).toString();
           break; 
        case Operation.Sub:
           displayedNumbers = (a - double.parse(displayedNumbers)).toString();
           break;
         default:
       }
      }
    });
  }


  void operationButton(Operation op){
     setState(() {

      a = double.parse(displayedNumbers);
      operationState = op;

      if(!displayedNumbers.isEmpty){
        
        
        displayedNumbers = "";

      }
    });
  }

}




class NumberButton extends StatefulWidget {
  
  String symbol="";
  var _onPressed;

  NumberButton(symbol, _onPressed){
    this.symbol = symbol;
    this._onPressed = _onPressed;
  }
  @override
  State<NumberButton> createState() => _NumberButtonState(symbol,_onPressed);
}

class _NumberButtonState extends State<NumberButton> {
  String symbol = "";
  var _onPressed;
  _NumberButtonState(symbol, _onPressed){
    this.symbol = symbol;
    this._onPressed = _onPressed;

  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: _CalculadoraState.width/4,//Sera mejor que estas dimensiones sean relativas
      height: (_CalculadoraState.height - 100)/4,
    
      child: TextButton(
        onPressed: _onPressed,
        child: ButtonSymbol(symbol),
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Color.fromARGB(255, 133, 153, 168)
        ),
    ),
    );
  }
}

class OperationButtonStyle extends ButtonStyle{
  static ButtonStyle getOperationButtonStyle(){
    return TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Color.fromARGB(255, 190, 114, 0)
    );
  }

}


class ButtonSymbol extends StatelessWidget{

  String symbol = "";

  ButtonSymbol(String symbol){
    this.symbol = symbol;
  }

  @override
  Widget build(BuildContext context){
    return Text(
      symbol,
      style: const TextStyle(
        fontSize: 42
      )
      );
  } 
}