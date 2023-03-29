import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../mixins/snackbar_mixin.dart';

class SentenceCorrectionController extends GetxController with SnackbarMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  final _score = Rx<Map<String, bool>>({});
  Map<String, bool> get score => _score.value;

  bool isSuccess = false;

  // final Map<String, String> choices = {
  //   'heat': 'If you ___1___ water to a temperature of',
  //   'cool': 'If you ___1___ water to a temperature of',
  //   'games': 'we can play ___1___ on a computer.',
  //   'Computer': '___1___ is an electronic devices.',
  //   'time': 'A computer save our ___1___.',
  // };
  final Map<String, dynamic> choices = {
    'games': 'we can play ___1___ on a computer.',
    'Computer': '___1___ is an electronic devices.',
    'time': 'A computer save our ___1___.',
  };

  //int refresh = 0;
  final _refreshWords = 0.obs;
  int get refreshWords => _refreshWords.value;

  onAccept(words) {
    score[words] = true;
    update();
    print(_score);
  }

  onRefresh() {
    score.clear();
    update();
  }

  onTappedDoneButton() {
    if (score.length < choices.length) {
      showErrorSnackbar(title: 'Warning', message: 'Answer is Incomplete!');
      return;
    }
    isSuccess = score.length == choices.length;
    if (isSuccess) {
      showSuccessSnackbar(title: 'Success', message: 'Success');
    }
  }
}
