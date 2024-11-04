import 'package:aula13_checkpoint3/domain/car.dart';
import 'package:dio/dio.dart';
import 'device.service.dart';

class RequestService {
  final host = "https://gdapp.com.br/api";

  Future<bool> sendAnimalData(Car car) async {
    final dio = Dio();
    final deviceService = DeviceService();
    final info = await deviceService.info();

    final data = {
      'car': car.toJson(),
      'device_info': info,
    };

    try {
      final response = await dio.post(
        '$host/car',
        data: data,
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
