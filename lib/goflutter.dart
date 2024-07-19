
import 'goflutter_platform_interface.dart';

class Goflutter {
  Future<String?> getPlatformVersion() {
    return GoflutterPlatform.instance.getPlatformVersion();
  }
}
