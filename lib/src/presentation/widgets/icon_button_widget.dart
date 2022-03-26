import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      splashColor: color,
      elevation: 2.0,
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
      padding: const EdgeInsets.all(10.0),
      shape: CircleBorder(
        side: BorderSide(
          width: 4.0,
          style: BorderStyle.solid,
          color: color,
        ),
      ),
    );
  }
}
