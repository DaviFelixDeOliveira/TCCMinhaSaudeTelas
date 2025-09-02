import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';

class VisualizarDocumentoApagado extends StatefulWidget {
  final String tituloDocumento;
  final String paciente;
  final String medico;
  final String tipoDocumento;
  final String dataDocumento;
  final String dataExclusao;

  const VisualizarDocumentoApagado({
    super.key,
    required this.tituloDocumento,
    required this.paciente,
    required this.medico,
    required this.tipoDocumento,
    required this.dataDocumento,
    required this.dataExclusao,
  });

  @override
  State<VisualizarDocumentoApagado> createState() =>
      _VisualizarDocumentoApagadoState();
}

class _VisualizarDocumentoApagadoState
    extends State<VisualizarDocumentoApagado> {
  int abaAtiva = 2; // exemplo: Lixeira

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Navbar(
                      mostrarImagem: false,
                      mostrarIconeVoltar: true,
                      mostrarIconeMais: false,
                      titulo: widget.tituloDocumento,
                    ),
                    const SizedBox(height: 16),

                    _buildCard(context, 'Nome do(a) Paciente', widget.paciente),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Nome do(a) Médico(a)', widget.medico),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Tipo de Documento', widget.tipoDocumento),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Data do Documento', widget.dataDocumento),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Excluído em', widget.dataExclusao),
                    const SizedBox(height: 24),

                    // --- Ações ---
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Ações',
                        style: TextStyle(
                          color: Color(0xFF171C1E),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildBotao(
                            cor: const Color(0xFF006879),
                            texto: 'Restaurar',
                            iconePath: 'assets/images/restore.png',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 12),
                          _buildBotao(
                            cor: const Color(0xFFBA1A1A),
                            texto: 'Excluir Permanentemente',
                            icone: Icons.delete_outline,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomNavbar(
            indexAtivo: abaAtiva,
            onTap: (index) {
              setState(() {
                abaAtiva = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String titulo, String valor) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: 0.15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              valor,
              style: const TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotao({
    required Color cor,
    required String texto,
    IconData? icone,
    String? iconePath,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconePath != null)
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 4),
              child: Image.asset(iconePath, width: 20, height: 20),
            )
          else if (icone != null)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(icone, color: Colors.white, size: 20),
            ),
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.43,
              letterSpacing: 0.10,
            ),
          ),
        ],
      ),
    );
  }
}
