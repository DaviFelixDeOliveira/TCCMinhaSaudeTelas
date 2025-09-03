import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String? codigoGerado; // código gerado dinamicamente
  List<String> codigosCriados = []; // lista de códigos criados

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

  String gerarCodigoAleatorio() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(10, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

  void _compartilharDocumentos() {
    codigoGerado = gerarCodigoAleatorio();
    codigosCriados.add(codigoGerado!);

    Clipboard.setData(ClipboardData(text: codigoGerado!));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Código '$codigoGerado' criado com sucesso"),
        duration: const Duration(seconds: 3),
      ),
    );

    setState(() {});
  }

  bool get algumSelecionado =>
      selecionados.values.any((selecionado) => selecionado);

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
                children: [
                  // Lista de pacientes e documentos
                  ...pacientes.entries.map((entry) {
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

                  // Lista de códigos gerados
                  ...codigosCriados.map((codigo) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF5FAFC),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFBFC8CB)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      codigo,
                                      style: const TextStyle(
                                        color: Color(0xFF171C1E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                            ClipboardData(text: codigo));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Código '$codigo' copiado"),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          codigosCriados.remove(codigo);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Válido até 02-06-2025 | 18:00',
                                  style: TextStyle(
                                      color: Color(0xFF171C1E), fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Botões
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
                    onTap: () => Navigator.pop(context),
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
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: algumSelecionado ? _compartilharDocumentos : null,
                    child: Opacity(
                      opacity: algumSelecionado ? 1.0 : 0.4,
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
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.10,
                            ),
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
        onTap: (index) {},
      ),
    );
  }
}
