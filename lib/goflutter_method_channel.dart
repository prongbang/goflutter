import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'goflutter_platform_interface.dart';

/// An implementation of [GoflutterPlatform] that uses method channels.
class MethodChannelGoflutter extends GoflutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('goflutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
