import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/snack_bar.dart';

class HoldProgressButtonWidget extends StatefulWidget {
  const HoldProgressButtonWidget({
    Key? key,
    required this.completed,
    required this.onChangeCompleteStatus,
  }) : super(key: key);

  final bool completed;
  final VoidCallback onChangeCompleteStatus;

  @override
  State<HoldProgressButtonWidget> createState() =>
      _HoldProgressButtonWidgetState();
}

class _HoldProgressButtonWidgetState extends State<HoldProgressButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverse();
        } else if (controller.status == AnimationStatus.completed) {
          widget.onChangeCompleteStatus();
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              context: context,
              label: widget.completed
                  ? LocaleKeys.moved_to_uncompleted.tr()
                  : LocaleKeys.moved_to_completed.tr(),
            ),
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const SizedBox(
            height: 45,
            width: 45,
            child: CircularProgressIndicator(
              value: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: CircularProgressIndicator(
              key: widget.key,
              value: controller.value,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.green,
              ),
            ),
          ),
          Icon(
            widget.completed ? Icons.repeat_sharp : Icons.check,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
