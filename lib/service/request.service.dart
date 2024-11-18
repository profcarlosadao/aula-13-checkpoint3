import 'package:aula13_checkpoint3/domain/car.dart';
import 'package:dio/dio.dart';

class RequestService {
  final dio = Dio();
  final host = "https://gdapp.com.br/api";

  Future<List<Car>> readCarsService() async {
    try {
      final response = await dio.get('$host/cars');
      return (response.data as List)
          .map((json) => Car.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> createCarService(Car car) async {
    final data = {'car': car.toJson()};

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
