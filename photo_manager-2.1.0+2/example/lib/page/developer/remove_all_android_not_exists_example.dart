import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class RemoveAndroidNotExistsExample extends StatefulWidget {
  const RemoveAndroidNotExistsExample({Key? key}) : super(key: key);

  @override
  State<RemoveAndroidNotExistsExample> createState() =>
      _RemoveAndroidNotExistsExampleState();
}

class _RemoveAndroidNotExistsExampleState
    extends State<RemoveAndroidNotExistsExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove android not exists assets.'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Click and see android logcat log.'),
            onPressed: () {
              PhotoManager.editor.android.removeAllNoExistsAsset();
            },
          ),
        ],
      ),
    );
  }
}
