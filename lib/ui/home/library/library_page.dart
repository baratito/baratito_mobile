import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Library',
                style: context.theme.text.title,
              )
            ],
          ),
          const SizedBox(height: 200),
          SizedBox(
            height: 300,
            width: 400,
            child: Image.network(
              'https://c.tenor.com/OtjbBfwQHeIAAAAC/fizzer1k-5597.gif',
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
