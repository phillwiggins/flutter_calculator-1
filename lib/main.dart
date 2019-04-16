import 'package:flutter/material.dart';
import 'package:flutter_calculator/bloc/main_bloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MainBloc _mainBloc = MainBloc();

  List<Widget> buildNumberButtons(int count, int from, int flex) {
    return new Iterable.generate(count, (index) {
      return new Expanded(
        flex: flex,
        child: new Padding(
          padding: const EdgeInsets.all(1.0),
          child: FlatButton(
              onPressed: () => _mainBloc.numberPressed(from + index),
              color: Colors.white,
              child: Text(
                "${from + index}",
                style: TextStyle(fontSize: 40.0),
              )),
        ),
      );
    }).toList();
  }

  Widget buildOperatorButton(String label, int flex,
      {Color color = Colors.amber}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: FlatButton(
            onPressed: () => _mainBloc.operatorPressed(label),
            color: color,
            child: Text(
              label,
              style: TextStyle(fontSize: 40.0),
            )),
      ),
    );
  }

  Widget buildRow(int numberKeyCount, int startNumber, int numberFlex,
      String operationLabel, int operationFlex) {
    return new Expanded(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: new List.from(buildNumberButtons(
              numberKeyCount,
              startNumber,
              numberFlex,
            ))
              ..add(buildOperatorButton(operationLabel, operationFlex))));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new SafeArea(
      child: new Material(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  _getResultText(_mainBloc),
                  _getInputText(_mainBloc)
                ])),
            buildRow(3, 7, 1, "/", 1),
            buildRow(3, 4, 1, "x", 1),
            buildRow(3, 1, 1, "-", 1),
            buildRow(1, 0, 3, "+", 1),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildOperatorButton("C", 1, color: Colors.grey),
                buildOperatorButton("=", 3)
              ],
            ))
          ],
        ),
      ),
    ));
  }

  Widget _getResultText(MainBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.result,
      initialData: "",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Text(snapshot.data,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 30.0, color: Colors.white)),
        );
      },
    );
  }

  Widget _getInputText(MainBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.input,
      initialData: "",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Text(snapshot.data,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 25.0, color: Colors.white)),
        );
      },
    );
  }
}
