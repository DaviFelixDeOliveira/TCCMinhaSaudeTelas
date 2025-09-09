import 'package:flutter/material.dart';
import 'widgets/bottom_navbar.dart';
import 'widgets/navbar.dart';
import 'telas/Lixeira/listarDocumentosApagados.dart';
import 'telas/Compartilhamento/codigosCompartilhamento.dart';
import 'telas/Lixeira/listarDocumentosApagados.dart'; // Importação CORRETA para documentos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Saúde',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE9EFF1),
          foregroundColor: Color(0xFF171C1E),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int abaAtiva = 0;

  @override
  Widget build(BuildContext context) {
    Widget telaAtual;

    switch (abaAtiva) {
      case 0: // Documentos - CORRIGIDO
        telaAtual = const ListarDocumentosApagados(documentos: []);
        break;
      case 1: // Compartilhar
        telaAtual = const CodigosCompartilhamento();
        break;
      case 2: // Lixeira
        telaAtual = const ListarDocumentosApagados(documentos: []);
        break;
      case 3: // Configurações
      default:
        telaAtual = Scaffold(
          appBar: AppBar(
            title: const Text('Configurações'),
            backgroundColor: const Color(0xFFE9EFF1),
          ),
          body: const Center(
            child: Text(
              'Tela de Configurações em desenvolvimento',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF171C1E),
              ),
            ),
          ),
        );
        break;
    }

    return Scaffold(
      body: telaAtual,
      bottomNavigationBar: BottomNavbar(
        indexAtivo: abaAtiva,
        onTap: (index) {
          setState(() {
            abaAtiva = index;
          });
        },
      ),
    );
  }
}