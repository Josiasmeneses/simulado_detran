import 'package:flutter/material.dart';
import 'package:simulado_detran/page/quiz_screen.dart' hide State;
import 'package:simulado_detran/util/config_simulado.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _mostrarDialogoEditar(BuildContext context) {
    final qtdController = TextEditingController(
      text: ConfigSimulado.quantidadeQuestoes.toString(),
    );
    final tempoController = TextEditingController(
      text: ConfigSimulado.tempoMin.toString(),
    );
    final acertosController = TextEditingController(
      text: ConfigSimulado.acertosMin.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Editar Simulado',
          style: TextStyle(color: Color(0xFF0D0D0D)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qtdController,
              decoration: InputDecoration(labelText: 'Questões:máx 30'),
            ),
            TextField(
              controller: tempoController,
              decoration: InputDecoration(labelText: 'Tempo (min)'),
            ),
            TextField(
              controller: acertosController,
              decoration: InputDecoration(labelText: 'Acertos mínimos'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Salvar'),
            onPressed: () {
              setState(() {
                ConfigSimulado.quantidadeQuestoes =
                    int.tryParse(qtdController.text) ?? 30;
                ConfigSimulado.tempoMin =
                    int.tryParse(tempoController.text) ?? 40;
                ConfigSimulado.acertosMin =
                    int.tryParse(acertosController.text) ?? 21;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FA),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 32),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1A8CBF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset('images/png/logo.png', height: 100),
              ),
            ),
            SizedBox(height: 24),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detalhes do Simulado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => _mostrarDialogoEditar(context),
                          child: Text(
                            'Editar',
                            style: TextStyle(color: Color(0xFF033F73)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    infoItem(Icons.book, 'Simulado Detran'),
                    infoItem(
                      Icons.list,
                      'Questões: ${ConfigSimulado.quantidadeQuestoes}',
                    ),
                    infoItem(
                      Icons.timer,
                      'Tempo: ${ConfigSimulado.tempoMin} min',
                    ),
                    infoItem(
                      Icons.check_circle,
                      'Acertos Mínimos: ${ConfigSimulado.acertosMin}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF033F73),
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen()),
                );
              },
              child: Text(
                'Iniciar Simulado',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget infoItem(IconData icon, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8),
          Text(texto, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
