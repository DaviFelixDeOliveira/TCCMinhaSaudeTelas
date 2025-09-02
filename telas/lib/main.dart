import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/bottom_navbar.dart';
import 'telas/Lixeira/visualizarDocumentoApagado.dart';

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
              child: Image.asset(
                iconePath,
                fit: BoxFit.contain,
              ),
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

// --- Tela de documentos em Grid ---
class TelaDocumentos extends StatelessWidget {
  final List<Map<String, String>> documentos;

  const TelaDocumentos({
    super.key,
    required this.documentos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Navbar(
            mostrarIconeVoltar: true,
            mostrarIconeMais: true,
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
                children: documentos.map((doc) {
                  return DocumentoItem(
                    titulo: doc['titulo']!,
                    data: doc['data']!,
                    diasRestantes: doc['diasRestantes']!,
                    iconePath: 'assets/images/DocumentIcon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisualizarDocumentoApagado(
                            tituloDocumento: doc['titulo']!,
                            paciente: 'Ana Beatriz Rocha',
                            medico: 'Dra. Carolina Mendes',
                            tipoDocumento: 'Tomografia',
                            dataDocumento: doc['data']!,
                            dataExclusao: '02/09/2025', // Futuramente podemos substituir por cálculo baseado em diasRestantes
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        indexAtivo: 2, // Aba Lixeira ativa
        onTap: (index) {
          // Aqui você pode tratar a troca de abas
          print('Aba selecionada: $index');
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
      home: TelaDocumentos(
        documentos: [
          {
            'titulo': 'Tomografia da Jaqueline Souza',
            'data': '15/01/2023',
            'diasRestantes': '30',
          },
          {
            'titulo': 'Hemograma do Marcos Lima',
            'data': '02/2020',
            'diasRestantes': '15',
          },
          {
            'titulo': 'Hemograma da Ana Beatriz Rocha',
            'data': '03/2020',
            'diasRestantes': '25',
          },
          {
            'titulo': 'Tomografia do Haldol Daniel',
            'data': '12/2021',
            'diasRestantes': '5',
          },
        ],
      ),
    );
  }
}
