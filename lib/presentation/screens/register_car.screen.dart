
import 'package:flutter/material.dart';
import '../controller/car.controller.dart';

class RegisterCarScreen extends StatefulWidget {
  const RegisterCarScreen({super.key});

  @override
  State<RegisterCarScreen> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterCarScreen> {
  late CarController _carController;
  final TextEditingController _chassiController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    _carController = CarController();
    super.initState();
  }

  _showSnackBar(String message) {
    final snackBar =
        SnackBar(content: Text(message), duration: const Duration(seconds: 3));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _clear() {
    _chassiController.clear();
    _nameController.clear();
    _yearController.clear();
  }

  _onPressed() async {
    final result = await _carController.createCar(
      chassi: _chassiController.text,
      name: _nameController.text,
      year: _yearController.text,
    );

    if (result) {
      _showSnackBar("Carro cadastrado com sucesso!");
    } else {
      _showSnackBar("Falha ao cadastrar carro!");
    }
    _clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Cadastro",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _chassiController,
              decoration: const InputDecoration(label: Text("informe o Chassí")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text("informe o nome")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _yearController,
              decoration: const InputDecoration(label: Text("informe o ano")),
            ),
          ),
          ElevatedButton(onPressed: _onPressed, child: const Text("Salvar")),
        ],
      ),
    );
  }
}
