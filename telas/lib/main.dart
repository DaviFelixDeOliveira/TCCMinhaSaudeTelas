import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/navbar.dart';
import '../widgets/bottom_navbar.dart';

class ListarCompartilhamento extends StatefulWidget {
  const ListarCompartilhamento({super.key});

  @override
  State<ListarCompartilhamento> createState() =>
      _ListarCompartilhamentoState();
}

class _ListarCompartilhamentoState extends State<ListarCompartilhamento> {
  int abaAtiva = 1;

  final List<Map<String, String>> codigos = [
    {'codigo': 'IMBLI7S8QO', 'validade': '02-06-2025 | 18:00'},
    {'codigo': 'A1B2C3D4E5', 'validade': '15-07-2025 | 12:00'},
    {'codigo': 'Z9Y8X7W6V5', 'validade': '20-08-2025 | 09:30'},
    {'codigo': 'QWERTY1234', 'validade': '01-09-2025 | 14:45'},
    {'codigo': 'ASDFGH5678', 'validade': '10-10-2025 | 16:00'},
  ];

  void mostrarSnackbar(String mensagem) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF2B3133),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        content: Row(
          children: [
            Expanded(
              child: Text(
                mensagem,
                style: const TextStyle(
                  color: Color(0xFFECF2F4),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: 0.25,
                ),
              ),
            ),
            IconButton(
              onPressed: () => scaffoldMessenger.hideCurrentSnackBar(),
              icon: const Icon(Icons.close, size: 24, color: Color(0xFFECF2F4)),
              tooltip: 'Fechar',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Navbar(
            mostrarIconeVoltar: true,
            mostrarIconeMais: false,
            mostrarImagem: true,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 380,
              child: Text(
                'Códigos de Compartilhamento',
                style: TextStyle(
                  color: Color(0xFF171C1E),
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.27,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: codigos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = codigos[index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF5FAFC),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFBFC8CB),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Lado esquerdo: código e validade
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item['codigo']!,
                                    style: const TextStyle(
                                      color: Color(0xFF171C1E),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 1.50,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: item['codigo']!));
                                      mostrarSnackbar(
                                          'Código copiado para a área de transferência');
                                    },
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: const Icon(
                                        Icons.copy,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Válido até ${item['validade']}',
                                style: const TextStyle(
                                  color: Color(0xFF171C1E),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.43,
                                  letterSpacing: 0.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Lado direito: ícone de deletar
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline,
                              size: 24, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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

// --- Main ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Saúde',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ListarCompartilhamento(),
    );
  }
}
