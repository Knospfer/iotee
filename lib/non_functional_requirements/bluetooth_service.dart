import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:iotee/core/constants.dart';

class IoteeBluetoothMessagingService {
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

  Future<void> sendMessage(String message, {Function? callback}) async {
    await writeCharacteristic.write(utf8.encode("$message \n"));
    callback?.call();
  }
}
