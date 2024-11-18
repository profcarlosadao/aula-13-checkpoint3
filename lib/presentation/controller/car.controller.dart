import 'package:get/get.dart';
import '../../domain/car.dart';
import '../../service/request.service.dart';

class CarController extends GetxController {
  final _requestService = RequestService();
  Rx<List<Car>> cars = Rx([]);
  Rx<bool> loading = Rx(false);

  CarController();

  Future<void> fetchCars() async {
    loading.value = true;
    cars.value = await _requestService.readCarsService();
    loading.value = false;
  }

  Future<bool> createCar({
    required String chassi,
    required String name,
    required String year,
  }) async {
    final car = Car(chassi: chassi, name: name, year: year);
    return  await _requestService.createCarService(car);
  }
}
