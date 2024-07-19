import 'package:flutter_test/flutter_test.dart';
import 'package:goflutter/goflutter.dart';
import 'package:goflutter/goflutter_platform_interface.dart';
import 'package:goflutter/goflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGoflutterPlatform
    with MockPlatformInterfaceMixin
    implements GoflutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GoflutterPlatform initialPlatform = GoflutterPlatform.instance;

  test('$MethodChannelGoflutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGoflutter>());
  });

  test('getPlatformVersion', () async {
    Goflutter goflutterPlugin = Goflutter();
    MockGoflutterPlatform fakePlatform = MockGoflutterPlatform();
    GoflutterPlatform.instance = fakePlatform;

    expect(await goflutterPlugin.getPlatformVersion(), '42');
  });
}
