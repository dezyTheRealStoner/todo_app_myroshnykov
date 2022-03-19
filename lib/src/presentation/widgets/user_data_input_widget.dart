import 'package:flutter/material.dart';

class UserDataInputWidget extends StatefulWidget {
  const UserDataInputWidget({
    Key? key,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
    required this.errorText,
  }) : super(key: key);

  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? errorText;

  @override
  _UserDataInputWidgetState createState() => _UserDataInputWidgetState();
}

class _UserDataInputWidgetState extends State<UserDataInputWidget> {
  final FocusNode focusNode = FocusNode();

  String hintText = '';
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPasswordField;
    hintText = widget.hintText;
    focusNode.addListener(() {
      focusNode.hasFocus ? hintText = '' : hintText = widget.hintText;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant UserDataInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    hintText == '' ? hintText = '' : hintText = widget.hintText;
    if (!obscureText) {
      obscureText = widget.isPasswordField;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Stack(
        children: [
          TextFormField(
            key: widget.key,
            controller: widget.controller,
            obscureText: obscureText,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              errorText: widget.errorText,
              errorMaxLines: 3,
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 10),
              disabledBorder: _defaultInputBorder(context),
              enabledBorder: _defaultInputBorder(context),
              focusedBorder: _defaultInputBorder(context),
              errorBorder: _errorInputBorder(context),
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          widget.isPasswordField
              ? Positioned(
                  top: 0,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (obscureText == true) {
                          obscureText = false;
                        } else {
                          obscureText = true;
                        }
                      });
                    },
                    child: Icon(
                      obscureText
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              : const SizedBox(height: 0),
        ],
      ),
    );
  }

  UnderlineInputBorder _defaultInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
    );
  }

  UnderlineInputBorder _errorInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.onError, width: 1),
    );
  }
}
