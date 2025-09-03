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
  int abaAtiva = 2;

  void _mostrarDialogoExcluir() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
            child: Container(
              width: 312,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFE4E9EB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 24,
                      right: 24,
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: Color(0xFFBA1A1A),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Excluir Documento',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF171C1E),
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Ao excluir este item, ele será removido permanentemente e não poderá ser recuperado. Deseja continuar?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF3F484B),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 8,
                      right: 24,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancelar
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFBFC8CB),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Color(0xFF3F484B),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Excluir
                        Container(
                          decoration: ShapeDecoration(
                            color: const Color(0xFFBA1A1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(
                                dialogContext,
                              ).pop(); // Fecha o diálogo
                              Navigator.of(
                                context,
                              ).pop(); // Volta para tela anterior
                              _mostrarSnackbar(); // Mostra a snackbar
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Text(
                                'Excluir',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.10,
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
            ),
          ),
        );
      },
    );
  }

  void _mostrarSnackbar() {
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
            const Expanded(
              child: Text(
                'Documento apagado com sucesso.',
                style: TextStyle(
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
              onPressed: () {
                scaffoldMessenger.hideCurrentSnackBar();
              },
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
                    _buildCard(
                      context,
                      'Tipo de Documento',
                      widget.tipoDocumento,
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      context,
                      'Data do Documento',
                      widget.dataDocumento,
                    ),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Excluído em', widget.dataExclusao),
                    const SizedBox(height: 24),

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
                            onPressed: _mostrarDialogoExcluir,
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
            side: const BorderSide(width: 1, color: Color(0xFFBFC8CB)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
