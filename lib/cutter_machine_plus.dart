
import 'cutter_machine_plus_platform_interface.dart';

class CutterMachinePlus {

  Future<String?> searchBluetooth() {
    return CutterMachinePlusPlatform.instance.searchBluetooth();
  }

  Future<String?> connectBluetooth(address) {
    return CutterMachinePlusPlatform.instance.connectBluetooth(address);
  }

  Future<String?> cutFileBluetooth(file) {
    return CutterMachinePlusPlatform.instance.cutFileBluetooth(file);
  }
  Future<String?> cutFileWithHeightAndWidthBluetooth(file,{required int xoffset,required int yoffset,required int width,required int height , bool xflip = false, bool yflip = false,
    int ang = 0, bool section = false  }) {
    return CutterMachinePlusPlatform.instance.cutFileWithHeightAndWidthBluetooth(file, xoffset: xoffset, yoffset: yoffset, width: width, height: height,ang: 0,section: false,xflip: false,yflip: false);
  }

  Future<String?> setPressure(file) {
    return CutterMachinePlusPlatform.instance.setPressure(file);
  }
  Future<String?> setSpeed(file) {
    return CutterMachinePlusPlatform.instance.setSpeed(file);
  }
}
