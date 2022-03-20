import 'package:flutter/material.dart';

class OutlinedInputWidget extends StatefulWidget {
  const OutlinedInputWidget({
    required this.controller,
    this.errorText,
    this.maxLines,
    required this.maxLength,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? errorText;
  final String hintText;
  final int? maxLines;
  final int maxLength;

  @override
  State<OutlinedInputWidget> createState() => _OutlinedInputWidgetState();
}

class _OutlinedInputWidgetState extends State<OutlinedInputWidget> {
  final FocusNode focusNode = FocusNode();

  String hintText = '';
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    hintText = widget.hintText;
    focusNode.addListener(() {
      focusNode.hasFocus ? hintText = '' : hintText = widget.hintText;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant OutlinedInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    hintText == '' ? hintText = '' : hintText = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        minLines: 1,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          errorText: widget.errorText,
          errorMaxLines: 3,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          disabledBorder: _inputBorder(
            context: context,
            isError: widget.errorText != null,
          ),
          enabledBorder: _inputBorder(
            context: context,
            isError: widget.errorText != null,
          ),
          focusedBorder: _inputBorder(
            context: context,
            isError: widget.errorText != null,
          ),
          errorBorder: _inputBorder(
            context: context,
            isError: widget.errorText != null,
          ),
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder({
    required BuildContext context,
    required bool isError,
  }) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: isError
            ? Theme.of(context).colorScheme.onError
            : Theme.of(context).colorScheme.primary,
        width: 1,
      ),
    );
  }
}
