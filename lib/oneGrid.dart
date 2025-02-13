import 'package:flutter/material.dart';

class OneGrid extends StatelessWidget{

  const OneGrid ({super.key, required this.value, required this.onPress, required this.selected});

  final int value;
  final Function() onPress;

  final bool selected ;

  @override
  Widget build(BuildContext context) {

    return Container(
        child: InkWell(
            onTap: onPress,
            child: Container(
              decoration: BoxDecoration(
                color: selected?
                Colors.blueAccent.shade100.withAlpha(100) :
                Colors.transparent,
              ),
              child: Center(
                  child: Text(
                      value != 0 ? value.toString() : ''
                  )

              ),
            )
    )
    );
  }
}