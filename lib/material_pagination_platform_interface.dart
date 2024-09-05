import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'material_pagination_method_channel.dart';

abstract class MaterialPaginationPlatform extends PlatformInterface {
  /// Constructs a MaterialPaginationPlatform.
  MaterialPaginationPlatform() : super(token: _token);

  static final Object _token = Object();

  static MaterialPaginationPlatform _instance = MethodChannelMaterialPagination();

  /// The default instance of [MaterialPaginationPlatform] to use.
  ///
  /// Defaults to [MethodChannelMaterialPagination].
  static MaterialPaginationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MaterialPaginationPlatform] when
  /// they register themselves.
  static set instance(MaterialPaginationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
