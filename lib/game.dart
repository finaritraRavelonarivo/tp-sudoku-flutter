import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

import 'oneGrid.dart';

class Game extends StatefulWidget {
  const Game({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;
  late Puzzle sudoku;
  int _xSelect = -1;
  int _ySelect = -1;

  @override
  void initState() {
    super.initState();
    PuzzleOptions sudokuOptions = new PuzzleOptions();
    sudoku = new Puzzle(sudokuOptions);
    generateSudoku();
  }

  Future<void> generateSudoku() async {
    await sudoku.generate();
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void changeColor(x,y) {
    setState(() {
      _xSelect = x;
      _ySelect= y;
    });
  }

  bool isSelected(x,y) {
    return _xSelect == x && _ySelect == y;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 2;
    var width = MediaQuery.of(context).size.width;
    var maxSize = height > width ? width : height;
    var boxSize = (maxSize / 3).ceil().toDouble();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
                width: boxSize * 3,
                height: boxSize * 3,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(9, (x) {
                      return Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: SizedBox(
                            width: boxSize * 3,
                            height: boxSize * 3,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: List.generate(9, (y) {
                                return Container(
                                    width: boxSize,
                                    height: boxSize,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: OneGrid(
                                       value: sudoku.board()?.matrix()?[x][y].getValue() ?? 0,
                                        onPress: () {
                                         changeColor(x,y);
                                        },
                                        selected : isSelected(x, y),
                                    ));
                              }),
                            ),
                          ));
                    }))),
            Row(
              children: List.generate(5, (x) {
                return ElevatedButton(
                    onPressed: (){
                      var pos = Position(column: _ySelect, row: _xSelect);
                      sudoku.board()!.cellAt(pos).setValue(x+1);
                      setState(() {});
                    },
                    child: Text(
                        (x+1).toString()
                    ));
              })
            ),
            Row(
                children: List.generate(4, (x) {
                  return ElevatedButton(
                      onPressed: (){
                        var pos = Position(column: _ySelect, row: _xSelect);
                        sudoku.board()!.cellAt(pos).setValue(x+6);
                        setState(() {});
                      },
                      child: Text(
                          (x+6).toString()
                      ));
                })
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
