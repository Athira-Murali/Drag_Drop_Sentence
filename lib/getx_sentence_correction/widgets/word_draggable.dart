import 'package:flutter/material.dart';

class WordDraggable extends StatelessWidget {
  const WordDraggable({Key? key, required this.word, this.isSelected = false})
      : super(key: key);
  final String word;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            width: 0,
            height: 0,
            color: Colors.black,
          )
        : Container(
            width: 150,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 0,
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Text(
                word,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ));
  }
}
