import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'material_pagination_platform_interface.dart';

/// An implementation of [MaterialPaginationPlatform] that uses method channels.
class MethodChannelMaterialPagination extends MaterialPaginationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('material_pagination');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
