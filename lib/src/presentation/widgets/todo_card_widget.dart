import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/num_to_month.dart';

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
                padding: EdgeInsets.all(10),
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
                  Text(
                      '${dateTime.day} ${numToMonth(dateTime.month)} ${dateTime.year}'),
                  Row(
                    children: [
                      _buildIconButton(
                        icon: Icons.check,
                        color: Colors.green,
                      ),
                      _buildIconButton(
                        icon: Icons.toc,
                        color: Theme.of(context).colorScheme.primary,
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

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
  }) {
    return RawMaterialButton(
      onPressed: () {},
      splashColor: color,
      elevation: 2.0,
      child: Icon(
        icon,
        color: color,
        size: 25,
      ),
      padding: const EdgeInsets.all(10.0),
      shape: CircleBorder(
        side: BorderSide(
          width: 1.0,
          style: BorderStyle.solid,
          color: color,
        ),
      ),
    );
  }
}
