import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingStateProvider = ChangeNotifierProvider((ref) => LoadingState());

class LoadingState extends ChangeNotifier {
  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      notifyListeners();
    }
  }
}