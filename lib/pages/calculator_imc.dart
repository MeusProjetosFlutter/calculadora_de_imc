import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  CalculadoraIMC({super.key});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String resultado = "Informe seus dados";
  Color resultadoColor = Colors.green;


  String _processarCalculoIMC() {
    if (alturaController.text.isEmpty || pesoController.text.isEmpty) {
      return "Preencha peso e altura";
    }


    try {
      double altura = double.parse(alturaController.text.replaceAll(',', '.')); // Substitui vírgula por ponto
      double peso = double.parse(pesoController.text.replaceAll(',', '.'));   // Substitui vírgula por ponto

      if (altura <= 0 || peso <= 0) {
        return "Peso e altura devem ser positivos";
      }

      if(altura > 3){
        return "Altura inválida";
      }

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        return "Abaixo do peso (${imc.toStringAsFixed(1)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        return "Peso normal (${imc.toStringAsFixed(1)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        return "Sobrepeso (${imc.toStringAsFixed(1)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        return "Obesidade Grau I (${imc.toStringAsFixed(1)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        return "Obesidade Grau II (${imc.toStringAsFixed(1)})";
      } else if (imc >= 40) {
        return "Obesidade Grau III (${imc.toStringAsFixed(1)})";
      } else {
        return "Erro no cálculo"; // Nunca deveria acontecer com as validações acima
      }
    } catch (e) {
      return "Valores inválidos (use apenas números e '.' ou ',' para decimais)";
    }
  }


  void _resetFields() {
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      resultado = "Informe seus dados";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: _resetFields,
            ),
          ),
        ],
        title: Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.accessibility_rounded,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
                TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                    hintText: "Ex: 1,70",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: Text('m'),
                  ),
                ),
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                    hintText: "Ex: 70,5",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: Text('kg'),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        resultado = _processarCalculoIMC();
                        if (resultado.startsWith("Abaixo do peso")){
                          resultadoColor = Color.fromARGB(255, 255, 128, 0);
                        } else if (resultado.startsWith("Peso normal")){
                          resultadoColor = Colors.green;
                        } else if (resultado.startsWith("Sobrepeso")){
                          resultadoColor = Colors.red;
                        }
                        else if (resultado.startsWith("Obesidade")){
                          resultadoColor = Colors.red;
                        }
                        }
                      );

                      },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Calcular'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(resultado, style: TextStyle(color: resultadoColor),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
