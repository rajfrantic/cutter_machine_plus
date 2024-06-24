import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cutter_machine_plus_method_channel.dart';

abstract class CutterMachinePlusPlatform extends PlatformInterface {
  /// Constructs a CutterMachinePlusPlatform.
  CutterMachinePlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static CutterMachinePlusPlatform _instance = MethodChannelCutterMachinePlus();

  /// The default instance of [CutterMachinePlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelCutterMachinePlus].
  static CutterMachinePlusPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CutterMachinePlusPlatform] when
  /// they register themselves.
  static set instance(CutterMachinePlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> searchBluetooth() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> connectBluetooth(address) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> cutFileBluetooth(file) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> setPressure(file) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> setSpeed(file) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> cutFileWithHeightAndWidthBluetooth(file,
      {required int xoffset,
        required int yoffset,
        required int width,
        required int height,
        bool xflip = false,
        bool yflip = false,
        int ang = 0,
        bool section = false}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
