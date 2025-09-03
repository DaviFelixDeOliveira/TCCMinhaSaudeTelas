import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';

class SelecionarDocumentos extends StatefulWidget {
  const SelecionarDocumentos({super.key});

  @override
  State<SelecionarDocumentos> createState() => _SelecionarDocumentosState();
}

class _SelecionarDocumentosState extends State<SelecionarDocumentos> {
  final Map<String, bool> selecionados = {};

  final Map<String, List<String>> pacientes = {
    'Ana Beatriz Rocha': [
      'Exame de Sangue da Beatriz',
      'Receita pro Zoladex da Ana',
      'Tomografia do Abdômen',
      'Raio-x do Tórax',
    ],
    'Daniel Ferreira': [
      'Eletrocardiograma',
      'Receita para Omeprazol',
      'Resultado de Biópsia',
    ],
    'Jaqueline Souza': [
      'Consulta de Rotina',
      'Exame de Urina',
      'Ultrassom Renal',
    ],
    'Marcos Lima': [
      'Raio-x do Joelho',
      'Receita para Dipirona',
      'Tomografia Craniana',
    ],
  };

  @override
  void initState() {
    super.initState();
    for (var docs in pacientes.values) {
      for (var doc in docs) {
        selecionados[doc] = false;
      }
    }
  }

  Widget _buildDocumento(String titulo) {
    final selecionado = selecionados[titulo] ?? false;

    final conteudo = Container(
      width: 120,
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Image.asset('assets/images/DocumentIcon.png'),
              ),
              Positioned(
                left: 26,
                top: -2,
                child: Image.asset(
                  selecionado
                      ? 'assets/images/RadioChecked.png'
                      : 'assets/images/RadioUnchecked.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
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
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          selecionados[titulo] = !(selecionados[titulo] ?? false);
        });
      },
      child: selecionado ? conteudo : Opacity(opacity: 0.5, child: conteudo),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: pacientes.entries.map((entry) {
                  final nomePaciente = entry.key;
                  final documentos = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 380,
                        child: Text(
                          nomePaciente,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: documentos.map(_buildDocumento).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Botões Cancelar e Próximo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const ShapeDecoration(
              color: Color(0xFFE9EFF1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // volta para tela anterior
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCEE7EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Center(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Color(0xFF334A50),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // A ação do botão "Próximo" será implementada depois
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFF006879),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Center(
                        child: Text(
                          'Próximo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        indexAtivo: 1,
        onTap: (index) {
          // ação de navegação
        },
      ),
    );
  }
}
