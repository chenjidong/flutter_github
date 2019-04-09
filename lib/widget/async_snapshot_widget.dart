import 'package:flutter/material.dart';

typedef SuccessWidget = Widget Function(AsyncSnapshot snapshot);

///异步加载处理 widget
class AsyncSnapshotWidget extends StatelessWidget {
  AsyncSnapshot snapshot;
  SuccessWidget successWidget;

  AsyncSnapshotWidget({this.snapshot, @required this.successWidget});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _parseSnap();
  }

  Widget _parseSnap() {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('未开始');
        return Center(
          child: Text('准备加载'),
        );
      case ConnectionState.active:
        print('加载中...');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        return successWidget(snapshot);
      default:
        return null;
    }
  }
}
