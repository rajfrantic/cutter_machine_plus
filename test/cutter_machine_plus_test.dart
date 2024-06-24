import 'package:flutter_test/flutter_test.dart';
import 'package:cutter_machine_plus/cutter_machine_plus.dart';
import 'package:cutter_machine_plus/cutter_machine_plus_platform_interface.dart';
import 'package:cutter_machine_plus/cutter_machine_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCutterMachinePlusPlatform 
    with MockPlatformInterfaceMixin
    implements CutterMachinePlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> connectBluetooth(address) {
    // TODO: implement connectBluetooth
    throw UnimplementedError();
  }

  @override
  Future<String?> cutFileBluetooth(file) {
    // TODO: implement cutFileBluetooth
    throw UnimplementedError();
  }

  @override
  Future<String?> cutFileWithHeightAndWidthBluetooth(file, {required int xoffset, required int yoffset, required int width, required int height, bool xflip = false, bool yflip = false, int ang = 0, bool section = false}) {
    // TODO: implement cutFileWithHeightAndWidthBluetooth
    throw UnimplementedError();
  }

  @override
  Future<String?> searchBluetooth() {
    // TODO: implement searchBluetooth
    throw UnimplementedError();
  }

  @override
  Future<String?> setPressure(file) {
    // TODO: implement setPressure
    throw UnimplementedError();
  }

  @override
  Future<String?> setSpeed(file) {
    // TODO: implement setSpeed
    throw UnimplementedError();
  }
}

void main() {
  final CutterMachinePlusPlatform initialPlatform = CutterMachinePlusPlatform.instance;

  test('$MethodChannelCutterMachinePlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCutterMachinePlus>());
  });

  test('getPlatformVersion', () async {
    CutterMachinePlus cutterMachinePlusPlugin = CutterMachinePlus();
    MockCutterMachinePlusPlatform fakePlatform = MockCutterMachinePlusPlatform();
    CutterMachinePlusPlatform.instance = fakePlatform;
  

  });
}
