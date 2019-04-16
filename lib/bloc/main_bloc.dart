import 'package:flutter_calculator/bloc/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements BlocBase {
  final BehaviorSubject<String> _resultString =
      BehaviorSubject<String>(seedValue: "");

  Stream<String> get result => _resultString.stream;
  _addToResultDisplay(String input) => _resultString.sink.add(input);

  final BehaviorSubject<String> _inputString =
      BehaviorSubject<String>(seedValue: "");

  Stream<String> get input => _inputString.stream;
  _addToInputDisplay(String input) => _inputString.sink.add(input);

  double accu = 0.0;
  double operand = 0.0;
  String resultString = "0.0";

  void numberPressed(int value) {
    // TODO remove - this tests bloc display updates
    _addToInputDisplay('$value');
    _updateResult('$value');
  }

  void operatorPressed(String label) {
    // TODO remove - this tests bloc display updates
    _addToInputDisplay(label);
    _updateResult(label);
  }

  void calculate() {}

  void _updateResult(String result) {
    _addToResultDisplay(result);
  }

  @override
  void dispose() {
    _resultString.close();
    _inputString.close();
  }
}
