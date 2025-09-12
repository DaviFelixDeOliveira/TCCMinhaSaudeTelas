import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';
import 'editarMetadados.dart';

class VisualizarDocumento extends StatefulWidget {
  final Map<String, dynamic> documento;

  const VisualizarDocumento({super.key, required this.documento});

  @override
  State<VisualizarDocumento> createState() => _VisualizarDocumentoState();
}

class _VisualizarDocumentoState extends State<VisualizarDocumento> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPanelOpen = false;
  bool _mostrarMenuOpcoes = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
      if (_isPanelOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _toggleMenuOpcoes() {
    setState(() {
      _mostrarMenuOpcoes = !_mostrarMenuOpcoes;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta! < -5) {
      if (!_isPanelOpen) {
        _togglePanel();
      }
    } else if (details.primaryDelta! > 5) {
      if (_isPanelOpen) {
        _togglePanel();
      }
    }
  }

  void _editarDocumento() {
    _toggleMenuOpcoes();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarMetadados(documento: widget.documento),
      ),
    ).then((resultado) {
      if (resultado != null) {
        setState(() {
          widget.documento.addAll(resultado);
        });
        _mostrarSnackBarEditado();
        
        // Retornar para a tela anterior com os dados atualizados
        Navigator.pop(context, {'editado': true, 'documento': widget.documento});
      }
    });
  }

  void _removerDocumento() {
    _toggleMenuOpcoes();
    _mostrarDialogoExclusao();
  }

  void _baixarDocumento() {
    _toggleMenuOpcoes();
    print('Baixar documento: ${widget.documento['titulo']}');
  }

  void _imprimirDocumento() {
    _toggleMenuOpcoes();
    print('Imprimir documento: ${widget.documento['titulo']}');
  }

  void _mostrarSnackBarEditado() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100),
        content: _buildSnackBarEditado(),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _mostrarSnackBarExcluido() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100),
        content: _buildSnackBarExcluido(),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildSnackBarEditado() {
    return Container(
      width: 344,
      height: 48,
      padding: const EdgeInsets.only(left: 16),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B3133),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
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
        children: [
          const Expanded(
            child: Text(
              'Dados editados com sucesso',
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
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.close, color: Color(0xFFECF2F4), size: 24),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSnackBarExcluido() {
    return Container(
      width: 344,
      height: 48,
      padding: const EdgeInsets.only(left: 16),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B3133),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
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
        children: [
          const Expanded(
            child: Text(
              'Documento movido para a lixeira.',
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
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.close, color: Color(0xFFECF2F4), size: 24),
            ),
          )
        ],
      ),
    );
  }

  void _mostrarDialogoExclusao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: _buildDialogoExclusao(),
        );
      },
    );
  }

  Widget _buildDialogoExclusao() {
    return ConstrainedBox(
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 264,
                    child: Text(
                      'Excluir Documento?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF171C1E),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 264,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Tem certeza que deseja mover ',
                            style: TextStyle(
                              color: Color(0xFF3F484B),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                          TextSpan(
                            text: widget.documento['titulo'] ?? 'Este documento',
                            style: const TextStyle(
                              color: Color(0xFF3F484B),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                          const TextSpan(
                            text: ' para a lixeira?',
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
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 24,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 48,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFBFC8CB),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color(0xFF3F484B),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                        _mostrarSnackBarExcluido();
                        
                        // Aguarda a SnackBar aparecer antes de voltar
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          // Retorna para a tela anterior com um indicador de exclusão
                          Navigator.pop(context, {'excluido': true, 'documento': widget.documento});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBA1A1A),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Excluir',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF171C1E),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                    letterSpacing: 0.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
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
        ],
      ),
    );
  }

  Widget _buildMenuOpcoes() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 112, maxWidth: 280),
      child: Container(
        width: 261,
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
          children: [
            _buildMenuItem(Icons.edit, 'Editar', _editarDocumento),
            _buildMenuItem(Icons.delete, 'Remover', _removerDocumento),
            _buildMenuItem(Icons.download, 'Baixar', _baixarDocumento),
            _buildMenuItem(Icons.print, 'Imprimir', _imprimirDocumento),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(icon, size: 24, color: const Color(0xFF171C1E)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Navbar(
                mostrarImagem: false,
                mostrarIconeVoltar: true,
                tipoIconeDireito: NavbarIcon.mais,
                titulo: 'Documento',
                onIconeDireitoPressed: _toggleMenuOpcoes,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.document_scanner,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: const BottomNavbar(indexAtivo: 0),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      height: _animation.value * screenHeight * 0.5,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4F6),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(28),
                          topRight: const Radius.circular(28),
                          bottomLeft: Radius.circular(_isPanelOpen ? 0 : 28),
                          bottomRight: Radius.circular(_isPanelOpen ? 0 : 28),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _togglePanel,
                              onVerticalDragUpdate: _onVerticalDragUpdate,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 4,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF70797B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Text(
                              'Informações',
                              style: TextStyle(
                                color: Color(0xFF171C1E),
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.27,
                              ),
                            ),
                            const SizedBox(height: 16),

                            _buildInfoCard(
                              'Título',
                              widget.documento['titulo'] ?? 'Sem título',
                            ),
                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Adicionado em',
                              widget.documento['dataAdicao'] ?? 'Data não informada',
                            ),
                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Nome do(a) paciente',
                              widget.documento['paciente'] ?? 'Paciente não informado',
                            ),
                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Tipo de documento',
                              widget.documento['tipo'] ?? 'Tipo não informado',
                            ),
                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Médico responsável',
                              widget.documento['medico'] ?? 'Médico não informado',
                            ),
                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Data do documento',
                              widget.documento['dataDocumento'] ?? 'Data não informada',
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                if (!_isPanelOpen)
                  GestureDetector(
                    onTap: _togglePanel,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: const Color(0xFFEFF4F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 32,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF70797B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          if (_mostrarMenuOpcoes)
            Positioned(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: _buildMenuOpcoes(),
            ),
        ],
      ),
    );
  }
}