import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import 'visualizarDocumentoApagado.dart';

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
final List<Map<String, dynamic>> documentos;

  const ListarDocumentosApagados({super.key, required this.documentos});

  @override
  State<ListarDocumentosApagados> createState() =>
      _ListarDocumentosApagadosState();
}

class _ListarDocumentosApagadosState extends State<ListarDocumentosApagados> {
  int abaAtiva = 2;
  late List<Map<String, String>> documentos;

  @override
  void initState() {
    super.initState();
    // Inicializa com documentos fictícios se a lista estiver vazia
    documentos = widget.documentos.isEmpty 
      ? _getDocumentosFicticios()
      : List.from(widget.documentos);
  }

  // Documentos fictícios para exemplo
  List<Map<String, String>> _getDocumentosFicticios() {
    return [
      {
        'titulo': 'Receita Médica',
        'data': '15/12/2023',
        'diasRestantes': '5',
        'paciente': 'João Silva',
        'medico': 'Dra. Ana Costa',
        'tipoDocumento': 'Receita',
        'dataExclusao': '20/12/2023'
      },
      {
        'titulo': 'Exame de Sangue',
        'data': '10/12/2023',
        'diasRestantes': '3',
        'paciente': 'Maria Santos',
        'medico': 'Dr. Carlos Lima',
        'tipoDocumento': 'Exame',
        'dataExclusao': '18/12/2023'
      }
    ];
  }

  void removerDocumento(int index) {
    setState(() {
      documentos.removeAt(index);
    });
  }

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
      // REMOVIDO: bottomNavigationBar daqui (será adicionado no main.dart)
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Navbar(
            mostrarIconeVoltar: false,
            mostrarImagem: true,
            tipoIconeDireito: NavbarIcon.nenhum,
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
              child: documentos.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum documento apagado ainda',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(documentos.length, (index) {
                        final doc = documentos[index];
                        return DocumentoItem(
                          titulo: doc['titulo']!,
                          data: doc['data']!,
                          diasRestantes: doc['diasRestantes']!,
                          iconePath: 'assets/images/DocumentIcon.png',
                          onTap: () async {
                            // Navegar para a tela de visualização e aguardar resultado
                            final resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VisualizarDocumentoApagado(
                                  tituloDocumento: doc['titulo']!,
                                  paciente: doc['paciente'] ?? '',
                                  medico: doc['medico'] ?? '',
                                  tipoDocumento: doc['tipoDocumento'] ?? '',
                                  dataDocumento: doc['data'] ?? '',
                                  dataExclusao: doc['dataExclusao'] ?? '',
                                ),
                              ),
                            );
                            
                            // Verificar o tipo de ação realizada
                            if (resultado != null) {
                              removerDocumento(index);
                              
                              if (resultado == 'excluido') {
                                mostrarSnackbar('Documento excluído com sucesso');
                              } else if (resultado == 'restaurado') {
                                mostrarSnackbar('Documento restaurado com sucesso');
                              }
                            }
                          },
                        );
                      }),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}