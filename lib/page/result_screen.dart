import 'package:flutter/material.dart';
import 'package:simulado_detran/models/questao_modelo.dart';
import 'package:simulado_detran/util/config_simulado.dart';

class ResultadoScreen extends StatelessWidget {
  final List<QuestaoModelo> questoes;
  final List<int> respostaUsuario;
  final Duration tempo;

  const ResultadoScreen({
    super.key,
    required this.questoes,
    required this.respostaUsuario,
    required this.tempo,
  });

  @override
  Widget build(BuildContext context) {
    int acertos = 0;
    for (int i = 0; i < questoes.length; i++) {
      if (respostaUsuario[i] == questoes[i].respostaCorreta) {
        acertos++;
      }
    }
    final aprovado = acertos >= ConfigSimulado.acertosMin;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'Resultado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      aprovado ? Icons.check_circle : Icons.cancel,
                      color: aprovado ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 26),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aprovado ? 'Aprovado' : 'Reprovado',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: aprovado ? Colors.green : Colors.red,
                          ),
                        ),
                        Text(
                          'Tempo Gasto: ${tempo.inMinutes} minutos e ${tempo.inSeconds % 60} segundos',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '✓ Acertos: $acertos',
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    '✕ erros: $acertos',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questoes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final correta = questoes[index].respostaCorreta;
                  final resposta = respostaUsuario[index];
                  final acertou = resposta == correta;

                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: acertou ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
