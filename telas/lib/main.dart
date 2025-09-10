import 'package:flutter/material.dart';
import 'telas/Listar Arquivos/listarArquivos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Saúde',
      debugShowCheckedModeBanner: false,
      home: const ListarArquivos(), // Agora aponta para ListarArquivos
      routes: {
        '/documentos': (context) => const ListarArquivos(), // Atualiza a rota também
      },
    );
  }
}