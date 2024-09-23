
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class OtpNotifier extends _$OtpNotifier {
  @override
  String build() {
    return '';
  }

  void addNum(String num) {
    if (state.length < 6 && int.tryParse(num) != null) {
      state += num;
    }
  }

  void removeLast() {
    state = state.substring(0, state.length - 1);
  }
}
