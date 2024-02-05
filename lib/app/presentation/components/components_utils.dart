import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';
import 'package:flutter_arduino/app/presentation/app_text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.height,
    this.width,
    this.text,
    this.buttonStyle,
    this.child,
    this.onPressed,
    this.textStyle = AppTextStyle.buttonTextStyle,
    this.buttonColor = AppColors.accentColor,
  }) : assert(text == null || child == null, 'text или child должен быть null');

  /// Высота кнопки
  final double? height;

  /// Ширина кнопки
  final double? width;

  /// Текст кнопки
  final String? text;

  /// Стиль кнопки
  final ButtonStyle? buttonStyle;

  /// Виджет-потомок, если нет текста кнопки
  final Widget? child;

  /// Событие при нажатии
  final VoidCallback? onPressed;

  /// Стиль текста кнопки
  final TextStyle textStyle;

  /// Цвет кнопки
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
        child: text != null ? Text(text!, style: textStyle) : child,
      ),
    );
  }
}

bool isKeyboardVisible(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 1;
}
