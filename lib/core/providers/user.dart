import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CurrentUserNotifier extends StateNotifier<UserEntity?> {
  CurrentUserNotifier() : super(null);

  void changeUser(UserEntity? user) {
    state = user;
  }
}

final currentUserNotifierProvider =
    StateNotifierProvider<CurrentUserNotifier, UserEntity?>(
        (ref) => CurrentUserNotifier());
