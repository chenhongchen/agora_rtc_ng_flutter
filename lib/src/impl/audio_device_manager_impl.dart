import 'dart:convert';

import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_ng/src/impl/api_caller.dart';
import 'package:agora_rtc_ng/src/audio_device_manager.dart';
import 'package:agora_rtc_ng/src/binding/audio_device_manager_impl.dart'
    as audio_device_manager_impl_binding;

// ignore_for_file: public_member_api_docs

extension DeviceInfoListExt on List<AudioDeviceInfo> {
  void fill(dynamic rm) {
    final devicesList = List.from(rm);
    // final List<AudioDeviceInfo> deviceInfoList = [];
    for (final d in devicesList) {
      final dm = Map<String, dynamic>.from(d);

      // deviceInfoList.add(AudioDeviceInfo.fromJson(dm));
      add(AudioDeviceInfo.fromJson(dm));
    }
  }
}

class AudioDeviceManagerImpl extends audio_device_manager_impl_binding
    .AudioDeviceManagerImpl implements AudioDeviceManager {
  static AudioDeviceManagerImpl? _instance;

  AudioDeviceManagerImpl._();

  static AudioDeviceManager create() {
    if (_instance != null) return _instance!;

    _instance = AudioDeviceManagerImpl._();

    return _instance!;
  }

  @override
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices() async {
    const apiType = 'AudioDeviceManager_enumeratePlaybackDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);

    return deviceInfoList;
  }

  @override
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices() async {
    const apiType = 'AudioDeviceManager_enumerateRecordingDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);

    return deviceInfoList;
  }

  @override
  Future<AudioDeviceInfo> getPlaybackDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<AudioDeviceInfo> getRecordingDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getRecordingDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<void> release() async {
    _instance = null;
  }
}
