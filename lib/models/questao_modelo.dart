class QuestaoModelo {
  final int id;
  final String questao;
  final List<String> opcoes;
  final int respostaCorreta;

  QuestaoModelo({
    required this.id,
    required this.questao,
    required this.opcoes,
    required this.respostaCorreta,
  });
  factory QuestaoModelo.fromMap(Map<String, dynamic> map) {
    return QuestaoModelo(
      id: map['id'],
      questao: map['pergunta'],
      opcoes: [map['opcao_1'], map['opcao_2'], map['opcao_3'], map['opcao_4']],
      respostaCorreta: map['opcao_correta'],
    );
  }
}
