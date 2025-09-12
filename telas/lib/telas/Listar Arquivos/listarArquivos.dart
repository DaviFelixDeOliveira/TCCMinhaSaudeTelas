import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';
import '../Gerenciar Documentos/visualizarDocumento.dart';

// Import das telas para navegação
import '../Compartilhamento/codigosCompartilhamento.dart';
import '../Lixeira/listarDocumentosApagados.dart';

class ListarArquivos extends StatefulWidget {
  const ListarArquivos({super.key});

  @override
  State<ListarArquivos> createState() => _ListarArquivosState();
}

class _ListarArquivosState extends State<ListarArquivos> {
  bool mostrarAcoes = false;
  bool mostrarMenuOrdenacao = false;
  String criterioOrdenacao = 'Nome do Paciente';

  // Dados fictícios mais completos
  final List<Map<String, dynamic>> documentos = [
    {
      'paciente': 'Ana Beatriz Rocha',
      'titulo': 'Exame de Sangue',
      'tipo': 'Exame Laboratorial',
      'medico': 'Dr. Carlos Silva',
      'dataDocumento': '2024-01-15',
      'dataAdicao': '2024-01-16'
    },
    {
      'paciente': 'Ana Beatriz Rocha',
      'titulo': 'Receita pro Zoladex',
      'tipo': 'Receita Médica',
      'medico': 'Dra. Maria Santos',
      'dataDocumento': '2024-02-10',
      'dataAdicao': '2024-02-11'
    },
    {
      'paciente': 'Ana Beatriz Rocha',
      'titulo': 'Tomografia do Abdômen',
      'tipo': 'Exame de Imagem',
      'medico': 'Dr. João Oliveira',
      'dataDocumento': '2024-03-05',
      'dataAdicao': '2024-03-06'
    },
    {
      'paciente': 'Daniel Ferreira',
      'titulo': 'Eletrocardiograma',
      'tipo': 'Exame Cardiológico',
      'medico': 'Dr. Carlos Silva',
      'dataDocumento': '2024-01-20',
      'dataAdicao': '2024-01-21'
    },
    {
      'paciente': 'Daniel Ferreira',
      'titulo': 'Receita para Omeprazol',
      'tipo': 'Receita Médica',
      'medico': 'Dra. Ana Costa',
      'dataDocumento': '2024-02-15',
      'dataAdicao': '2024-02-16'
    },
    {
      'paciente': 'Daniel Ferreira',
      'titulo': 'Resultado de Biópsia',
      'tipo': 'Exame Laboratorial',
      'medico': 'Dr. Paulo Mendes',
      'dataDocumento': '2024-03-10',
      'dataAdicao': '2024-03-11'
    },
    {
      'paciente': 'Jaqueline Souza',
      'titulo': 'Consulta de Rotina',
      'tipo': 'Consulta',
      'medico': 'Dra. Maria Santos',
      'dataDocumento': '2024-01-25',
      'dataAdicao': '2024-01-26'
    },
    {
      'paciente': 'Jaqueline Souza',
      'titulo': 'Exame de Urina',
      'tipo': 'Exame Laboratorial',
      'medico': 'Dr. Carlos Silva',
      'dataDocumento': '2024-02-20',
      'dataAdicao': '2024-02-21'
    },
    {
      'paciente': 'Jaqueline Souza',
      'titulo': 'Ultrassom Renal',
      'tipo': 'Exame de Imagem',
      'medico': 'Dr. João Oliveira',
      'dataDocumento': '2024-03-15',
      'dataAdicao': '2024-03-16'
    },
    {
      'paciente': 'Marcos Lima',
      'titulo': 'Raio-x do Joelho',
      'tipo': 'Exame de Imagem',
      'medico': 'Dr. Paulo Mendes',
      'dataDocumento': '2024-01-30',
      'dataAdicao': '2024-01-31'
    },
    {
      'paciente': 'Marcos Lima',
      'titulo': 'Receita para Dipirona',
      'tipo': 'Receita Médica',
      'medico': 'Dra. Ana Costa',
      'dataDocumento': '2024-02-25',
      'dataAdicao': '2024-02-26'
    },
    {
      'paciente': 'Marcos Lima',
      'titulo': 'Tomografia Craniana',
      'tipo': 'Exame de Imagem',
      'medico': 'Dr. João Oliveira',
      'dataDocumento': '2024-03-20',
      'dataAdicao': '2024-03-21'
    },
  ];

  // Função para navegar entre as telas
  void _navegarParaTela(int index) {
    // Impede navegação redundante se já estivermos na tela atual
    if (index == 0) return;

    switch (index) {
      case 1: // Compartilhar
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CodigosCompartilhamento()),
        );
        break;
      case 2: // Lixeira
        Navigator.push(
          context,  
          MaterialPageRoute(
          builder: (context) => ListarDocumentosApagados(documentos: documentos),
        ),

        );
        break;
      case 3: // Configurações - criar esta tela posteriormente
        // Por enquanto, mostra um placeholder
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tela de Configurações em desenvolvimento')),
        );
        break;
    }
  }

  void toggleAcoes() {
    setState(() {
      mostrarAcoes = !mostrarAcoes;
    });
  }

  void toggleMenuOrdenacao() {
    setState(() {
      mostrarMenuOrdenacao = !mostrarMenuOrdenacao;
    });
  }

  void ordenarPor(String criterio) {
    setState(() {
      criterioOrdenacao = criterio;
      mostrarMenuOrdenacao = false;
    });
  }

  Map<String, List<Map<String, dynamic>>> agruparDocumentos() {
    Map<String, List<Map<String, dynamic>>> grupos = {};

    for (var documento in documentos) {
      String chave = '';

      switch (criterioOrdenacao) {
        case 'Nome do Paciente':
          chave = documento['paciente'];
          break;
        case 'Tipo de Documento':
          chave = documento['tipo'];
          break;
        case 'Nome do Médico':
          chave = documento['medico'];
          break;
        case 'Data do Documento':
          chave = documento['dataDocumento'];
          break;
        case 'Data de Adição':
          chave = documento['dataAdicao'];
          break;
        default:
          chave = documento['paciente'];
      }

      if (!grupos.containsKey(chave)) {
        grupos[chave] = [];
      }
      grupos[chave]!.add(documento);
    }

    // Ordenar as chaves alfabeticamente
    var chavesOrdenadas = grupos.keys.toList();
    chavesOrdenadas.sort();

    Map<String, List<Map<String, dynamic>>> gruposOrdenados = {};
    for (var chave in chavesOrdenadas) {
      gruposOrdenados[chave] = grupos[chave]!;
    }

    return gruposOrdenados;
  }

  Widget _buildDocumento(Map<String, dynamic> documento) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VisualizarDocumento(documento: documento),
          ),
        );
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/DocumentIcon.png'),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 112,
              child: Text(
                documento['titulo'],
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
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOrdenacao() {
    return Positioned(
      right: 16,
      top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 112, maxWidth: 280),
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: ShapeDecoration(
            color: const Color(0xFFE9EFF1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOpcaoOrdenacao('Agrupar por Nome do Paciente'),
              _buildOpcaoOrdenacao('Agrupar por Tipo de Documento'),
              _buildOpcaoOrdenacao('Agrupar por Nome do Médico'),
              _buildOpcaoOrdenacao('Agrupar por Data do Documento'),
              _buildOpcaoOrdenacao('Agrupar por Data de Adição'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpcaoOrdenacao(String texto) {
    return GestureDetector(
      onTap: () => ordenarPor(texto.replaceFirst('Agrupar por ', '')),
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                texto,
                style: const TextStyle(
                  color: Color(0xFF171C1E),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotaoDocumento() {
    return GestureDetector(
      onTap: toggleAcoes,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFA9EDFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
                color: Color(0x4C000000), blurRadius: 3, offset: Offset(0, 1)),
            BoxShadow(
                color: Color(0x26000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 3),
          ],
        ),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, color: Color(0xFF004E5C)),
              SizedBox(width: 8),
              Text(
                'Documento',
                style: TextStyle(
                  color: Color(0xFF004E5C),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.90,
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcoesDocumento() {
    return SizedBox(
      width: 148,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _acaoItem(Icons.document_scanner, 'Escanear', () {}),
          const SizedBox(height: 8),
          _acaoItem(Icons.upload_file, 'Upload', () {}),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: toggleAcoes,
            backgroundColor: const Color(0xFF006879),
            elevation: 6,
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _acaoItem(IconData icone, String texto, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFA9EDFF),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 24, color: const Color(0xFF004E5C)),
            const SizedBox(width: 8),
            Text(
              texto,
              style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final documentosAgrupados = agruparDocumentos();
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Navbar(
                mostrarImagem: true,
                mostrarIconeVoltar: false,
                tipoIconeDireito: NavbarIcon.sort,
                titulo: '',
                onIconeDireitoPressed: toggleMenuOrdenacao,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding + 80,
                  ),
                  child: documentosAgrupados.isEmpty
                      ? const Center(
                          child: Text('Nenhum documento encontrado'),
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: documentosAgrupados.entries.map((entry) {
                            final chave = entry.key;
                            final documentosGrupo = entry.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    chave,
                                    style: const TextStyle(
                                      color: Color(0xFF171C1E),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 1.50,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: documentosGrupo.map(_buildDocumento).toList(),
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          }).toList(),
                        ),
                ),
              ),
            ],
          ),
          
          if (mostrarMenuOrdenacao) _buildMenuOrdenacao(),
          
          Positioned(
            bottom: 80 + bottomPadding,
            right: 16,
            child: mostrarAcoes
                ? _buildAcoesDocumento()
                : _buildBotaoDocumento(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        indexAtivo: 0, // Documentos é a primeira aba
        onTap: _navegarParaTela,
      ),
    );
  }
}