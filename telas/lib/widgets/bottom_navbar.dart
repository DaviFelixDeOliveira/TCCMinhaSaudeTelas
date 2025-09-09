import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int indexAtivo;
  final Function(int)? onTap;

  const BottomNavbar({
    super.key,
    this.indexAtivo = 0,
    this.onTap,
  });

  void _navegarParaTela(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    // Impede navegação redundante
    if (index == indexAtivo) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/documentos');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/compartilhar');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/lixeira');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/configuracoes');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoIcone = 24.0;
    final tamanhoLabel = 12.0;

    final List<Map<String, dynamic>> abas = [
      {'icone': Icons.folder, 'label': 'Documentos'},
      {'icone': Icons.share, 'label': 'Compartilhar'},
      {'icone': Icons.delete, 'label': 'Lixeira'},
      {'icone': Icons.settings, 'label': 'Configurações'},
    ];

    return Container(
      width: double.infinity,
      height: 64,
      color: const Color(0xFFE9EFF1),
      child: Row(
        children: List.generate(abas.length, (index) {
          final ativo = index == indexAtivo;
          return Expanded(
            child: InkWell(
              onTap: () => _navegarParaTela(context, index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ativo ? const Color(0xFFCEE7EE) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      abas[index]['icone'],
                      color: ativo ? const Color(0xFF4B6268) : const Color(0xFF3F484B),
                      size: tamanhoIcone,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    abas[index]['label'],
                    style: TextStyle(
                      fontSize: tamanhoLabel,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: ativo ? const Color(0xFF4B6268) : const Color(0xFF3F484B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}