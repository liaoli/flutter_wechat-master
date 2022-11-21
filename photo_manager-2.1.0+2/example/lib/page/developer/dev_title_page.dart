import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../util/log.dart';

class DevelopingExample extends StatefulWidget {
  const DevelopingExample({Key? key}) : super(key: key);

  @override
  State<DevelopingExample> createState() => _DevelopingExampleState();
}

class _DevelopingExampleState extends State<DevelopingExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        child: const Text('Test title speed'),
        onPressed: () async {
          final DateTime start = DateTime.now();
          final PermissionState result =
              await PhotoManager.requestPermissionExtend();
          if (result.isAuth) {
            final List<AssetEntity> imageList = <AssetEntity>[];
            final List<AssetPathEntity> list =
                await PhotoManager.getAssetPathList(
              type: RequestType.image,
            );
            for (final AssetPathEntity path in list) {
              imageList.addAll(
                await path.getAssetListRange(start: 0, end: path.assetCount),
              );
            }
            if (imageList.isNotEmpty) {
              imageList.shuffle();
            }
          }
          final Duration diff = DateTime.now().difference(start);
          Log.d(diff);
        },
      ),
    );
  }
}
