import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/car.controller.dart';
import 'register_car.screen.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  late CarController _carController;

  @override
  void initState() {
    _carController = CarController();
    _carController.fetchCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de carros")),
      body: Obx(() {
        if (_carController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_carController.cars.value.isEmpty) {
          return const Center(
            child: Text('No cars available'),
          );
        }

        return ListView.builder(
          itemCount: _carController.cars.value.length,
          itemBuilder: (BuildContext context, int index) {
            final car = _carController.cars.value[index];
            return ListTile(
              title: Text(car.name),
              subtitle: Text(car.chassi),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterCarScreen()),
            );
          }),
    );
  }
}
