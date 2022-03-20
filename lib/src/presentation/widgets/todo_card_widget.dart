import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/num_to_month.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/icon_button_widget.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
  }) : super(key: key);

  final String title;
  final String description;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                          '${dateTime.day} ${numToMonth(dateTime.month)} ${dateTime.year}'),
                      const SizedBox(height: 10),
                      Text(DateFormat.Hm().format(dateTime)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButtonWidget(
                        icon: Icons.check,
                        color: Colors.green,
                        onTap: () {},
                      ),
                      IconButtonWidget(
                        icon: Icons.toc,
                        color: Theme.of(context).colorScheme.primary,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
