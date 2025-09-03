import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/navbar.dart';
import '../widgets/bottom_navbar.dart';
import 'telas/Compartilhamento/selecionarDocumentos.dart';

class ListarCompartilhamento extends StatefulWidget {
  const ListarCompartilhamento({super.key});

  @override
  State<ListarCompartilhamento> createState() =>
      _ListarCompartilhamentoState();
}

class _ListarCompartilhamentoState extends State<ListarCompartilhamento> {
  int abaAtiva = 1;

  final List<Map<String, String>> codigos = [];

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

  Future<void> _irParaCriarCodigo() async {
    final novoCodigo = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const SelecionarDocumentos()),
    );

    if (novoCodigo != null) {
      setState(() {
        codigos.insert(0, novoCodigo); // Adiciona o novo código no topo
      });
    }
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
              child: codigos.isEmpty
                  ? const Center(child: Text("Nenhum código gerado ainda."))
                  : ListView.separated(
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
                                          item['codigo'] ?? '',
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
                                              ClipboardData(
                                                  text: item['codigo'] ?? ''),
                                            );
                                            mostrarSnackbar(
                                              'Código copiado para a área de transferência',
                                            );
                                          },
                                          child: const Icon(
                                            Icons.copy,
                                            size: 16,
                                            color: Color(0xFF3F484B),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Válido até ${item['validade'] ?? ''}',
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
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    codigos.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 24,
                                  color: Colors.redAccent,
                                ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 8),
        child: GestureDetector(
          onTap: _irParaCriarCodigo,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFA9EDFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  spreadRadius: 3,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 56,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add, size: 24, color: Color(0xFF004E5C)),
                      SizedBox(width: 8),
                      Text(
                        'Novo Código',
                        style: TextStyle(
                          color: Color(0xFF004E5C),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
