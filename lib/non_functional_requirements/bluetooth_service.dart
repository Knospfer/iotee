import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iotee/core/constants.dart';

class IoteeBluetoothService {
  late final BluetoothCharacteristic readCharacteristic;
  late final BluetoothCharacteristic writeCharacteristic;

  Future<void> init(
    BluetoothDevice device, {
    required Function initFailedCallback,
  }) async {
    final services = await device.discoverServices();

    final service = services.firstWhereOrNull(
      (element) => element.uuid.toString() == SERVICE_UUID,
    );

    if (service == null) return initFailedCallback();

    final write = service.characteristics.firstWhereOrNull(
      (element) => element.uuid.toString() == WRITE_CHARACTERISTIC_UUID,
    );
    final read = service.characteristics.firstWhereOrNull(
      (element) => element.uuid.toString() == READ_CHARACTERISTIC_UUID,
    );

    if (read == null || write == null) return initFailedCallback();

    readCharacteristic = read;
    writeCharacteristic = write;
  }

  Future<void> sendMessageWithLoading(String message, {Function? callback}) =>
      _handleWithLoadings(
        () async {
          await writeCharacteristic.write(utf8.encode(message));
          Future.delayed(const Duration(milliseconds: 400));
          await writeCharacteristic.write(utf8.encode(message));
          Future.delayed(const Duration(milliseconds: 400));
          await writeCharacteristic.write(utf8.encode(message));
          Future.delayed(const Duration(milliseconds: 400));
          await writeCharacteristic.write(utf8.encode(message));
          Future.delayed(const Duration(milliseconds: 400));
          await writeCharacteristic.write(utf8.encode(message));
          Future.delayed(const Duration(milliseconds: 500));
          callback?.call();
        },
      );

  Future<void> _handleWithLoadings(Future Function() callback) async {
    EasyLoading.show(dismissOnTap: false);
    try {
      await callback();
    } catch (_) {
      await EasyLoading.showError("Error");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
