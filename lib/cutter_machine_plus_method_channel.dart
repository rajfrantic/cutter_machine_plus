import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cutter_machine_plus_platform_interface.dart';

/// An implementation of [CutterMachinePlusPlatform] that uses method channels.
class MethodChannelCutterMachinePlus extends CutterMachinePlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cutter_machine_plus');

  @override
  Future<String?> searchBluetooth() async {
    final version = await methodChannel.invokeMethod<String>('searchBluetooth');
    return version;
  }

  @override
  Future<String?> connectBluetooth(address) async {
    final version = await methodChannel.invokeMethod<String>('connectBluetooth',address);
    return version;
  }
  @override
  Future<String?> cutFileBluetooth(file) async {
    final version = await methodChannel.invokeMethod<String>('cutFileBluetooth',file);
    return version;
  }
  @override
  Future<String?> setPressure(file) async {
    final version = await methodChannel.invokeMethod<String>('setPressure',file);
    return version;
  }
  @override
  Future<String?> setSpeed(file) async {
    final version = await methodChannel.invokeMethod<String>('setSpeed',file);
    return version;
  }
  @override
  Future<String?> cutFileWithHeightAndWidthBluetooth(file,{required int xoffset,required int yoffset,required int width,required int height , bool xflip = false, bool yflip = false,
    int ang = 0, bool section = false  }) async {

    final version = await methodChannel.invokeMethod('cutFileWithHeightAndWidthBluetooth',<String, dynamic>{
      "file":file,
      "xoffset":xoffset,
      "yoffset":yoffset,
      "width":width,
      "height":height,
      "xflip":xflip,
      "yflip":yflip,
      "ang":ang,
      "section":section,
    });
    return version;
  }
}
