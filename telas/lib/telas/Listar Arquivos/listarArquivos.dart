import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';
import '../Gerenciar Documentos/visualizarDocumento.dart';

class ListarArquivos extends StatefulWidget {
  const ListarArquivos({super.key});

  @override
  State<ListarArquivos> createState() => _ListarArquivosState();
}

class _ListarArquivosState extends State<ListarArquivos> {
  bool mostrarAcoes = false;
  bool mostrarMenuOrdenacao = false;
  String criterioOrdenacao = 'Nome do Paciente';

  // Dados fictícios mais completos (todos os 12 documentos)
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

  void _navegarParaTela(int index) {
    if (index == 0) return;

    switch (index) {
      case 1:
        context.go('/compartilhar');
        break;
      case 2:
        context.go('/lixeira');
        break;
      case 3:
        context.go('/configuracoes');
        break;
    }
  }

  void toggleAcoes() => setState(() => mostrarAcoes = !mostrarAcoes);
  
  void toggleMenuOrdenacao() => setState(() => mostrarMenuOrdenacao = !mostrarMenuOrdenacao);
  
  void ordenarPor(String criterio) =>
      setState(() => {criterioOrdenacao = criterio, mostrarMenuOrdenacao = false});

  // Fechar menu de ordenação ao clicar fora
  void _fecharMenuOrdenacao() {
    if (mostrarMenuOrdenacao) {
      setState(() => mostrarMenuOrdenacao = false);
    }
  }

  Map<String, List<Map<String, dynamic>>> agruparDocumentos() {
    Map<String, List<Map<String, dynamic>>> grupos = {};
    for (var doc in documentos) {
      String chave = switch (criterioOrdenacao) {
        'Tipo de Documento' => doc['tipo'],
        'Nome do Médico' => doc['medico'],
        'Data do Documento' => doc['dataDocumento'],
        'Data de Adição' => doc['dataAdicao'],
        _ => doc['paciente'],
      };

      grupos.putIfAbsent(chave, () => []).add(doc);
    }

    final chavesOrdenadas = grupos.keys.toList()..sort();
    return {for (var chave in chavesOrdenadas) chave: grupos[chave]!};
  }

  Widget _buildDocumento(Map<String, dynamic> doc) {
    return GestureDetector(
      onTap: () async {
        final resultado = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VisualizarDocumento(documento: doc)),
        );
        
        // Atualizar a lista se o documento foi editado
        if (resultado != null && resultado['editado'] == true) {
          setState(() {
            final index = documentos.indexWhere((d) => d['titulo'] == doc['titulo']);
            if (index != -1) {
              documentos[index] = resultado['documento'];
            }
          });
        }
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Image.asset('assets/images/DocumentIcon.png', width: 48, height: 48),
            const SizedBox(height: 4),
            Text(
              doc['titulo'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                height: 1.33,
                letterSpacing: 0.50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOrdenacao() {
    const opcoes = [
      'Nome do Paciente',
      'Tipo de Documento',
      'Nome do Médico',
      'Data do Documento',
      'Data de Adição'
    ];

    return Positioned(
      right: 16,
      top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EFF1),
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Color(0x26000000), blurRadius: 6, offset: Offset(0, 2)),
            BoxShadow(color: Color(0x4C000000), blurRadius: 2, offset: Offset(0, 1)),
          ],
        ),
        child: Column(
          children: opcoes.map((opcao) {
            return GestureDetector(
              onTap: () => ordenarPor(opcao),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  'Agrupar por $opcao',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    color: Color(0xFF171C1E),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBotaoDocumento() {
    return GestureDetector(
      onTap: toggleAcoes,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFA9EDFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x4C000000), blurRadius: 3, offset: Offset(0, 1)),
            BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.add, color: Color(0xFF004E5C)),
            SizedBox(width: 8),
            Text(
              'Documento',
              style: TextStyle(
                color: Color(0xFF004E5C),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcoesDocumento() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _acaoItem(Icons.document_scanner, 'Escanear', () {}),
        const SizedBox(height: 8),
        _acaoItem(Icons.upload_file, 'Upload', () {}),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: toggleAcoes,
          backgroundColor: const Color(0xFF006879),
          child: const Icon(Icons.close),
        ),
      ],
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
            Icon(icone, color: const Color(0xFF004E5C)),
            const SizedBox(width: 8),
            Text(
              texto,
              style: const TextStyle(
                color: Color(0xFF004E5C),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final agrupados = agruparDocumentos();
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    return GestureDetector(
      onTap: _fecharMenuOrdenacao,
      child: Scaffold(
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
                  child: agrupados.isEmpty
                      ? const Center(child: Text('Nenhum documento encontrado'))
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: agrupados.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: entry.value.map(_buildDocumento).toList(),
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
            
            if (mostrarMenuOrdenacao) 
              GestureDetector(
                onTap: _fecharMenuOrdenacao,
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            
            if (mostrarMenuOrdenacao) _buildMenuOrdenacao(),
            
            Positioned(
              bottom: 80 + bottomPadding,
              right: 16,
              child: mostrarAcoes ? _buildAcoesDocumento() : _buildBotaoDocumento(),
            ),
          ],
        ),
       
      ),
    );
  }
}