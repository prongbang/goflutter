import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'goflutter_method_channel.dart';

abstract class GoflutterPlatform extends PlatformInterface {
  /// Constructs a GoflutterPlatform.
  GoflutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoflutterPlatform _instance = MethodChannelGoflutter();

  /// The default instance of [GoflutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoflutter].
  static GoflutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoflutterPlatform] when
  /// they register themselves.
  static set instance(GoflutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
