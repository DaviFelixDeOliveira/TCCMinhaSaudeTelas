import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';

// --- Widget do item de documento ---
class DocumentoItem extends StatelessWidget {
  final String titulo;
  final String iconePath;
  final String data;
  final String diasRestantes;
  final VoidCallback onTap;

  const DocumentoItem({
    super.key,
    required this.titulo,
    required this.iconePath,
    required this.data,
    required this.diasRestantes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Image.asset(iconePath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 112,
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF171C1E),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "$diasRestantes dias",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tela Lixeira ---
class ListarDocumentosApagados extends StatefulWidget {
  final List<Map<String, String>> documentos;

  const ListarDocumentosApagados({super.key, required this.documentos});

  @override
  State<ListarDocumentosApagados> createState() =>
      _ListarDocumentosApagadosState();
}

class _ListarDocumentosApagadosState extends State<ListarDocumentosApagados> {
  int abaAtiva = 2;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Navbar(
            mostrarIconeVoltar: true,
            mostrarIconeMais: false,
            mostrarImagem: true,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Lixeira',
              style: TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 22,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.27,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: widget.documentos.map((doc) {
                  return DocumentoItem(
                    titulo: doc['titulo']!,
                    data: doc['data']!,
                    diasRestantes: doc['diasRestantes']!,
                    iconePath: 'assets/images/DocumentIcon.png',
                    onTap: () {
                      // Aqui você chama a tela de visualização do documento apagado
                      // e passa os callbacks para restaurar ou excluir.
                    },
                  );
                }).toList(),
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
