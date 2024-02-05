import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.next = false,
    this.fieldAction = TextInputAction.done,
    this.keyboardType = TextInputType.name,
    this.hintText = '',
    this.textColor = Colors.black,
    this.inputFieldBorderColor = AppColors.inputFieldBorderColor,
    this.inputFieldColor = AppColors.inputFieldColor,
    this.controller,
    this.onComplete,
    this.onSaved,
    this.onChanged,
  });

  /// Переключать фокус с одного текстового поля на другое
  final bool next;

  /// Действие после заполнения поля
  final TextInputAction fieldAction;

  /// Формат клавиатуры
  final TextInputType keyboardType;

  /// Текст поля, когда оно пустое
  final String hintText;

  /// Цвет вводимого текста
  final Color textColor;

  /// Цвет текстового поля
  final Color inputFieldColor;

  /// Цвет рамки текстового поля
  final Color inputFieldBorderColor;

  /// Контроллер поля
  final TextEditingController? controller;

  /// Событие после заполнения поля
  final VoidCallback? onComplete;

  /// Событие при сохранении заполненных данных
  final void Function(String? text)? onSaved;

  /// Событие при вводе текста
  final void Function(String? text)? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode fieldNode;
  late bool hasTapped;

  @override
  void initState() {
    fieldNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    fieldNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: fieldNode,
      textInputAction: widget.fieldAction,
      style: TextStyle(color: widget.textColor),
      cursorColor: widget.inputFieldBorderColor,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.only(left: 16),
        focusColor: widget.inputFieldBorderColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.inputFieldBorderColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: widget.inputFieldColor,
        filled: true,
      ),
      onEditingComplete: () {
        if (widget.next) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
          widget.onComplete?.call();
        }
      },
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}
