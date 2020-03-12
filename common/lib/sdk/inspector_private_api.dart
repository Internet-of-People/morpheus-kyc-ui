import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_common/sdk/http_tools.dart';

class InspectorPrivateApi {
  static Log _log = Log(InspectorPrivateApi);
  static InspectorPrivateApi _instance;
  final String _apiUrl;
  final String name;

  InspectorPrivateApi(this._apiUrl, this.name);

  static InspectorPrivateApi get instance => _instance == null ? throw Exception('InspectorPrivateApi is no yet set') : _instance;

  static InspectorPrivateApi setAsEmulator() => _instance = InspectorPrivateApi('http://${HttpTools.host}:8081', 'Inspector');

  static InspectorPrivateApi setAsRealDevice(url) => _instance = InspectorPrivateApi(url, 'Inspector');

  // TBD
}