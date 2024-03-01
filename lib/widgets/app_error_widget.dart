import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String msg;
  final Null Function()? onRetry;

  const AppErrorWidget({super.key, required this.msg, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(msg ?? ''),
      SizedBox(height: 20),
      ElevatedButton(
          onPressed: this.onRetry ?? (){}, child: Text('Retry'.toUpperCase()))
    ]));
  }
}
