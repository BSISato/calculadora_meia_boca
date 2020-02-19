import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/*Definindo uma TYPEDEF (OperadorFunc) e usando biblioteca "dart:math"
que contém constantes e funções mais um ferador de números aleatórios
Uma typedef, ou um alias de tipo de função, ajuda a definir ponteiros para o código executável na memória. 
Assim, uma typedef pode ser usado como um ponteiro que faz referência a uma função. */
typedef OperadorFunc = double Function(double valor, double operando);

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  double valor = 0.0;
  double operando = 0.0;
  OperadorFunc filadeOperacao;
  String resultadoString = "0.0";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          //cor visor resultado
          child: Material(
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                //VISOR
                Expanded( 
                    child: Row( 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        resultadoString,
                        textAlign: TextAlign.right,
                        style:
                            //cor numeros visor resultado
                            TextStyle(fontSize: 60.0, color: Colors.black),
                      )
                    ])),
                buildRow(3, 7, 1, "÷", (valor, divisor) => valor / divisor, 1),
                buildRow(3, 4, 1, "x", (valor, divisor) => valor * divisor, 1),
                buildRow(3, 1, 1, "-", (valor, divisor) => valor - divisor, 1),
                buildRow(1, 0, 3, "+", (valor, divisor) => valor + divisor, 1),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildOperadorBotoes("C", null, 2, color: Colors.black38),
                      buildOperadorBotoes("=", (valor, divisor) => valor, 3,color: Colors.black54)
                    ],
                  ),
                ),
                //ultima linha
               Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: <Widget>[
                        Text(
                          'Flutter 10 x 0 React',
                          style: TextStyle(fontSize: 35.0, color: Colors.white),
                        ),
                      ]
                    ),
                )
              ],
            ),
          ),
        ));
  }

  void numeroPressionado(int valor) {
    operando = operando * 10 + valor;
    setState(() => resultadoString = operando.toString());
  }

  void calcular(OperadorFunc operacao) {
    if (operacao == null) {
      valor = 0.0;
    } else {
      valor =
          filadeOperacao != null ? filadeOperacao(valor, operando) : operando;
    }
    filadeOperacao = operacao;
    operando = 0.0;
    var resultado = valor.toString();
    setState(() => resultadoString =
        resultado.toString().substring(0, min(10, resultado.length)));
  }

  buildNumeroBotoes(int count, int from, int flex) {
    return Iterable.generate(count, (index) {
      return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
              onPressed: () => numeroPressionado(from + index),
              //teclado 
              color: Colors.black,
              child: Text(
                "${from + index}",
                //teclado text
                style: TextStyle(fontSize: 40.0, color: Colors.orange),
              )),
        ),
      );
    }).toList();
  }

  buildOperadorBotoes(String label, OperadorFunc func, int flex,
      //cor text operadores
      {Color color = Colors.black}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: FlatButton(
            onPressed: () => calcular(func),
            color: color,
            //operdores
            child: Text(
              label,
              style: TextStyle(fontSize: 40.0, color: Colors.white),
              
            )),
      ),
    );
  }

  buildRow(int numberKeyCount, int startNumber, int numberFlex,
      String operationLabel, OperadorFunc operacao, int operrationFlex) {
    return Expanded(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.from(buildNumeroBotoes(
              numberKeyCount,
              startNumber,
              numberFlex,
            ))
              ..add(buildOperadorBotoes(
                  operationLabel, operacao, operrationFlex))));
  }
}
