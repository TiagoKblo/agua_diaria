import 'package:flutter_bloc/flutter_bloc.dart';

class WaterCubit extends Cubit<Map<String, dynamic>> {
  WaterCubit() : super({
    'showAlert': true,
    'goal': 8, // Meta inicial de 8 copos
    'consumed': 0, // Quantidade de copos consumidos
    'history': <DateTime>[], // Inicializa como uma lista vazia de DateTime
  });

  // Adiciona um copo de água e registra a data
  void addWater() {
    final currentState = state;
    final updatedHistory = List<DateTime>.from(currentState['history']); // Garante que seja List<DateTime>
    updatedHistory.add(DateTime.now()); // Adiciona a data de consumo

    emit({
      'showAlert': currentState['showAlert'],
      'goal': currentState['goal'],
      'consumed': currentState['consumed'] + 1, // Incrementa o consumo
      'history': updatedHistory, // Atualiza o histórico com a data
    });
  }

  // Método para limpar o histórico
  void clearHistory() {
    emit({
      'showAlert': state['showAlert'],
      'consumed': state['consumed'],
      'goal': state['goal'],
      'history': <DateTime>[], // Limpa o histórico com uma nova lista de DateTime
    });
  }

  // Reseta o contador de copos consumidos
  void resetCounter() {
    emit({
      'showAlert': true,
      'goal': state['goal'],
      'consumed': 0,
      'history': state['history'], // O histórico permanece igual
    });
  }

  // Atualiza a meta diária
  void setGoal(int newGoal) {
    emit({
      'showAlert': true,
      'goal': newGoal,
      'consumed': state['consumed'], // Não muda a quantidade de consumidos
      'history': state['history'], // O histórico permanece igual
    });
  }
}
