import 'package:flutter/material.dart';

class SwitcherButtonWidget extends StatelessWidget {
  const SwitcherButtonWidget({
    Key? key,
    required this.selected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final bool selected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: _buildIcon(selected),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: onTap,
          child: Text(title),
        ),
      ],
    );
  }

  Widget _buildIcon(bool selected) {
    return selected
        ? const Image(
            image: AssetImage('assets/images/radio_button.png'),
          )
        : const Image(
            image: AssetImage('assets/images/empty_radio_button.png'),
          );
  }
}
