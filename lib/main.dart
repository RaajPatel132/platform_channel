import 'package:flutter/material.dart';
import 'package:platform_channel/method_channel_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BtteryScreen(),
    );
  }
}

class BtteryScreen extends StatelessWidget {
  const BtteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery'),
      ),
      body: Center(
        child: FutureBuilder<int>(
              future: MethodChannlService.getBatteryLevel(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Text('Battery Level: ${snapshot.data}%'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
      )
    );
  }
}
