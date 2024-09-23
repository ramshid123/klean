import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/features/cart/presentation/provider/filter_provider.dart';

class LoadingContainer extends ConsumerWidget {
  const LoadingContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(loadingStateProvider);
    return Stack(
      children: [
        child,
        if (state.isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.r, sigmaY: 5.r),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              height: size.height,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(30.r),
                    height: 100.r,
                    width: 100.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const CircularProgressIndicator(
                      color: ColorConstants.greenColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
