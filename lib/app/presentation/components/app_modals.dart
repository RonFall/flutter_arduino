import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';

class AppModals {
  static final _draggableBar = Container(
    height: 4.0,
    width: 48.0,
    decoration: BoxDecoration(
      color: AppColors.black.withOpacity(.25),
      borderRadius: const BorderRadius.all(Radius.circular(50)),
    ),
  );

  static const _modalBorderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  );

  static Future<T?> showScreenModal<T>(
    BuildContext context, {
    required List<Widget> children,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return showModalBottomSheet<T?>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: _modalBorderShape,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.8,
          expand: false,
          snap: true,
          builder: (_, scrollController) {
            return Stack(
              children: [
                Container(
                  color: AppColors.white,
                  margin: const EdgeInsets.only(top: 1),
                ),
                ListView(
                  controller: scrollController,
                  padding: padding,
                  children: children,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _draggableBar,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<T?> showModal<T>(
    BuildContext context, {
    required Widget child,
  }) {
    return showModalBottomSheet<T?>(
      context: context,
      shape: _modalBorderShape,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _draggableBar,
              ),
            ),
            child,
          ],
        );
      },
    );
  }
}
