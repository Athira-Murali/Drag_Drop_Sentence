import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/dimensions.dart';
import 'sentence_correction_controller.dart';
import 'widgets/word_draggable.dart';

class SentenceCorrectionView extends StatelessWidget {
  const SentenceCorrectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<SentenceCorrectionController>(
        init: SentenceCorrectionController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.fitWidth,
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                ),
                SafeArea(
                    right: false,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DragDrop(),
                          const SizedBox(width: 10),
                          _sideMenu()
                        ],
                      ),
                    ))
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //     child: const Icon(Icons.refresh),
            //     onPressed: () {
            //       setState(() {
            //         score.clear();
            //         refresh++;
            //       });
            //     }),
          );
        });
  }

  Widget _sideMenu() {
    final SentenceCorrectionController controller = Get.find();

    return Column(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/buttons/go_back.png",
          ),
          iconSize: iconSize,
          onPressed: () {},
        ),
        const Spacer(),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/buttons/repeat.png",
          ),
          iconSize: iconSize,
          onPressed: () => controller.onRefresh(),
        ),
        const SizedBox(
          height: 5,
        ),
        IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              "assets/images/buttons/toffee_shot.png",
            ),
            iconSize: iconSize,
            onPressed: () {}),
        const SizedBox(
          height: 5,
        ),
        IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              "assets/images/buttons/done.png",
            ),
            iconSize: iconSize,
            onPressed: () {
              controller.onTappedDoneButton();
            }),
      ],
    );
  }
}

class DragDrop extends StatelessWidget {
  DragDrop({
    Key? key,
  }) : super(key: key);
  final SentenceCorrectionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final smallmobile = MediaQuery.of(context).size.width < 550;
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              BoxConstraints? mConstraints;

              if (controller.isSuccess) {
                mConstraints = BoxConstraints(
                    minWidth: defaultItemHeight, minHeight: defaultItemHeight);
              } else {
                var spacing = 8.0;
                double idealItemWidth = defaultItemHeight;
                int totalItems = controller.choices.length;

                final maxWidth = constraints.maxWidth;

                final totalExpectedWidth =
                    totalItems * idealItemWidth + (totalItems - 1) * spacing;

                if (totalExpectedWidth > maxWidth) {
                  final itemWidth =
                      (totalExpectedWidth - maxWidth) / totalItems;
                  mConstraints = BoxConstraints(
                      maxWidth: defaultItemHeight - itemWidth,
                      maxHeight: defaultItemHeight);
                } else {
                  mConstraints = BoxConstraints(
                      minWidth: defaultItemHeight,
                      minHeight: defaultItemHeight);
                }
              }

              return Wrap(
                  runSpacing: 1.0,
                  spacing: 4.0,
                  children: controller.choices.keys.map((words) {
                    return Draggable<String>(
                      data: words,
                      feedback: WordDraggable(word: words),
                      childWhenDragging: WordDraggable(word: words),
                      child: Obx(
                        () => WordDraggable(
                          word: controller.score[words] == true ? '' : words,
                          isSelected:
                              controller.score[words] == true ? true : false,
                        ),
                      ),
                    );
                  }).toList()
                    ..shuffle(Random(controller.refreshWords)));
            }),
          ),
          const SizedBox(height: 30),
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                      children: controller.choices.keys
                          .map((words) => _buildDragTargetNew(words))
                          .toList()
                      //..shuffle(Random(refresh)
                      )),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildDragTargetNew(words) {
    final SentenceCorrectionController controller = Get.find();
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        String sentence = controller.choices[words]!;

        if (controller.score[words] == true) {
          sentence = sentence.replaceAllMapped(
              RegExp('___\\d+___'),
              (match) => match.group(0) == '___1___'
                  ? words
                  : match.group(0)); // replace the correct blank with the word
        } else {
          sentence = sentence.replaceAll(
              '___1___', '_______'); // replace the blank with a dashed line
        }
        return SizedBox(
          height: 30,
          child: Text(
            sentence,
            style: const TextStyle(fontSize: 20),
          ),
        );
      },
      onWillAccept: (data) => data == words,
      onAccept: (data) {
        controller.onAccept(words);
      },
      onLeave: (data) {},
    );
  }
}
