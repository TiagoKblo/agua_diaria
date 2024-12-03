import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/water_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4FC3F7),
        title: Text(
          'Água Diária',
          style: GoogleFonts.nunitoSans(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WaterCubit, Map<String, dynamic>>(
        builder: (context, state) {
          int consumed = state['consumed'];
          int goal = state['goal'];
          bool showAlert = state['showAlert'];

          // Exibir o SnackBar ou Dialog quando a meta for atingida
          if ((consumed >= goal) && showAlert) {
            state['showAlert'] = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showGoalAchievedDialog(context);
            });
          }

          return Container(
            color: const Color(0xFFE0F7FA),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Meta Diária',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showSetGoalDialog(context);
                        },
                        color: const Color(0xFF4FC3F7),
                        iconSize: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$consumed / $goal copos',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 22,
                      color: const Color(0xFF4FC3F7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      context.read<WaterCubit>().addWater();
                    },
                    child: Image.asset(
                      'assets/images/copo_de_agua.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WaterCubit>().resetCounter();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC3F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Resetar Consumo',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF212121),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Mostrar Histórico',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Função para mostrar o aviso de meta atingida
  void _showGoalAchievedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Meta Diária Atingida!'),
          content: const Text('Parabéns! Você atingiu a sua meta de copos de água.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Função para mostrar o dialog de definir a meta diária
  void _showSetGoalDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Definir Meta Diária'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Número de copos',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                int newGoal = int.tryParse(controller.text) ?? 8;
                context.read<WaterCubit>().setGoal(newGoal);
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}