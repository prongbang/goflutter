// import 'package:native_toolchain_go/go_native_toolchain.dart';
// import 'package:logging/logging.dart';
// import 'package:native_assets_cli/native_assets_cli.dart';
//
// void main(List<String> args) async {
//   await build(args, (config, output) async {
//     final packageName = config.packageName;
//
//     final goBuilder = GoBuilder(
//       name: packageName,
//       assetName: 'bridge.gen.dart',
//       bridgePath: 'go/bridge',
//       sources: ['go/'],
//       dartBuildFiles: ['hook/build.dart'],
//     );
//
//     await goBuilder.run(
//       buildConfig: config,
//       buildOutput: output,
//       logger: Logger('')
//         ..level = Level.ALL
//         ..onRecord.listen((record) => print(record.message)),
//     );
//   });
// }