import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/switcher_button_widget.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.switcherButtons,
    this.buttonIsOpen,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final List<SwitcherButtonWidget>? switcherButtons;
  final bool? buttonIsOpen;

  @override
  Widget build(BuildContext context) {
    return switcherButtons != null
        ? AnimatedCrossFade(
            firstChild: _buildButton(
              context: context,
              withSwitchers: true,
            ),
            secondChild: _buildButtonWithSwitchers(
              context: context,
              switcherButtonWidgets: switcherButtons!,
            ),
            duration: const Duration(milliseconds: 300),
            crossFadeState: buttonIsOpen!
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          )
        : _buildButton(
            context: context,
            withSwitchers: false,
          );
  }

  Widget _buildButton({
    required BuildContext context,
    required bool withSwitchers,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                width: 50,
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              withSwitchers
                  ? Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10)
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonWithSwitchers({
    required BuildContext context,
    required List<SwitcherButtonWidget> switcherButtonWidgets,
  }) {
    return Column(
      children: [
        _buildButton(context: context, withSwitchers: true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: switcherButtons!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SwitcherButtonWidget(
                selected: switcherButtons!.elementAt(index).selected,
                title: switcherButtons!.elementAt(index).title,
                onTap: switcherButtons!.elementAt(index).onTap,
              ),
            ),
          ),
        )
      ],
    );
  }
}
