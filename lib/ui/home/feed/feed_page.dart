import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tu feed',
                style: context.theme.text.title,
              )
            ],
          )
        ],
      ),
    );
  }
}
