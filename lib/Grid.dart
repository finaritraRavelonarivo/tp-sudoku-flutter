import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    var boxSize = 0.3;
    return SizedBox(
      width: boxSize * 3,
      height: boxSize * 3,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (x) {
          return Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),

          );
        }),
      ),

    );
  }

}