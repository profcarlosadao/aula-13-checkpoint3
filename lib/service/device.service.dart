import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  final _uuid = const Uuid();

  Future<Map<String, dynamic>> info() async {
    final deviceInfo = DeviceInfoPlugin();
    final uniqueId = await _getOrGenerateUid();

    late Map<String, dynamic> deviceData;

    if (kIsWeb) {
      var webInfo = await deviceInfo.webBrowserInfo;
      deviceData = {
        'browserName': webInfo.browserName.toString(),
        'platform': webInfo.platform,
        'userAgent': webInfo.userAgent,
        'unique_id': uniqueId,
      };
    } else if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceData = {
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'unique_id': uniqueId,
      };
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceData = {
        'model': iosInfo.utsname.machine,
        'system_version': iosInfo.systemVersion,
        'unique_id': uniqueId,
      };
    }

    return deviceData;
  }

  Future<String> _getOrGenerateUid() async {
    final prefs = await SharedPreferences.getInstance();
    const uidKey = 'device_uid';

    String? uid = prefs.getString(uidKey);

    if (uid == null) {
      uid = _uuid.v4();
      await prefs.setString(uidKey, uid);
    }

    return uid;
  }
}
