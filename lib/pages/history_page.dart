import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/water_cubit.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Consumo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showClearHistoryDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<WaterCubit, Map<String, dynamic>>(
        builder: (context, state) {
          List<DateTime> history = state['history'];

          if (history.isEmpty) {
            return const Center(
              child: Text(
                'Histórico vazio! Beba água para começar.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              DateTime date = history[index];
              return ListTile(
                leading: const Icon(Icons.local_drink),
                title: Text('Copo ${index + 1}'),
                subtitle: Text(date.toLocal().toString()),
              );
            },
          );
        },
      ),
    );
  }

  // Função para mostrar o diálogo de confirmação de limpeza do histórico
  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Limpar Histórico'),
          content: const Text('Você tem certeza de que deseja limpar todo o histórico?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<WaterCubit>().clearHistory(); // Limpa o histórico
                Navigator.of(context).pop(); // Fecha o dialog
              },
              child: const Text('Limpar'),
            ),
          ],
        );
      },
    );
  }
}