import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulado_detran/models/questao_modelo.dart';
import 'package:simulado_detran/page/home_screen.dart';
import 'package:simulado_detran/page/result_screen.dart';
import 'package:simulado_detran/util/config_simulado.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  List<QuestaoModelo> questoes = [];
  int perguntaAtual = 0;
  int? respostaSelecionada;
  List<int> respostaUsuario = [];
  late Stopwatch cronometro;

  static const MethodChannel _channel = MethodChannel('screen_capture');

  @override
  void initState() {
    super.initState();
    cronometro = Stopwatch()..start();
    carregarQuestoes();
  }

  Future<void> carregarQuestoes() async {
    final tabela = 'simulado_detran';
    final response = await Supabase.instance.client
        .from(tabela)
        .select()
        .limit(ConfigSimulado.quantidadeQuestoes);

    final lista = response.map((q) => QuestaoModelo.fromMap(q)).toList();
    lista.shuffle();

    setState(() {
      questoes = lista;
    });
  }

  void proximaPergunta() {
    respostaUsuario.add(respostaSelecionada ?? -1);
    respostaSelecionada = null;

    if (perguntaAtual < questoes.length - 1) {
      setState(() {
        perguntaAtual++;
      });
    } else {
      cronometro.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadoScreen(
            questoes: questoes,
            respostaUsuario: respostaUsuario,
            tempo: cronometro.elapsed,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questoes.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final questao = questoes[perguntaAtual];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    },
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                  Text('${perguntaAtual + 1} de ${questoes.length}'),
                  StreamBuilder<int>(
                    stream: Stream.periodic(Duration(seconds: 1), (_) {
                      return cronometro.elapsed.inSeconds;
                    }),
                    builder: (context, snapshot) {
                      final segundosRestantes =
                          (ConfigSimulado.tempoMin * 60) - (snapshot.data ?? 0);
                      if (segundosRestantes <= 0) {
                        cronometro.stop();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResultadoScreen(
                                questoes: questoes,
                                respostaUsuario: respostaUsuario,
                                tempo: cronometro.elapsed,
                              ),
                            ),
                          );
                        });
                        return Text('00:00');
                      }
                      final minutos = (segundosRestantes ~/ 60)
                          .toString()
                          .padLeft(2, '0');
                      final segundos = (segundosRestantes % 60)
                          .toString()
                          .padLeft(2, '0');
                      return Text('$minutos:$segundos');
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              Text(questao.questao, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              ...List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      respostaSelecionada = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: respostaSelecionada == index
                          ? Color(0xFF0A8CBF)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    child: Text(
                      questao.opcoes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: respostaSelecionada == index
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }),
              Spacer(),

              ElevatedButton(
                onPressed: respostaSelecionada != null ? proximaPergunta : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff033f73),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Continuar",
                  style: TextStyle(color: Color(0xFFF7F7FA)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
