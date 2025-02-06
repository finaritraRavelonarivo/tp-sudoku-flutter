import 'package:flutter/material.dart';

class OneGrid extends StatelessWidget{
  const OneGrid({super.key, required this.gridValues});

  final List<int> gridValues;

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
            child:
                Center(
                  child:  Text(
                      gridValues[x] != 0 ? gridValues[x].toString() : ''
                  )
                )


          );
        }),
      ),

    );
  }

}