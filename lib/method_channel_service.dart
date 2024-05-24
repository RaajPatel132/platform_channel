
import 'package:flutter/services.dart';

class MethodChannlService {
  static const MethodChannel _channel = MethodChannel('BatteryInformation');

  static Future<int> getBatteryLevel() async {
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      return Future.error('Failed to get battery level: ${e.message}');
    }
  }
}