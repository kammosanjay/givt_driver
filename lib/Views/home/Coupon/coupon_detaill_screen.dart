import 'dart:async';
import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';

class DynamicViewAllPage extends StatefulWidget {
  DynamicViewAllPage({super.key});

  @override
  State<DynamicViewAllPage> createState() => _DynamicViewAllPageState();
}

class _DynamicViewAllPageState extends State<DynamicViewAllPage> {
  final StreamController<int> controller = StreamController<int>();
  late Timer _timer;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    // simulate data updates: increase count every 2 seconds
    _timer = Timer.periodic(Duration(microseconds: 1600), (timer) {
      _count++; // increase count
      controller.sink.add(_count); // add to stream
      if (_count == 4) {
        // stop after 10 updates
        controller.close();
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    controller.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myArgs = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(myArgs.toString())),
      body: StreamBuilder<int>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Waiting for data..."));
          }
          if (snapshot.hasData) {
            int currentCount = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  // mainAxisExtent: 120,
                ),
                itemCount: currentCount,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: Text("Stream Finished!"));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
