import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int indexAtivo; // índice da aba selecionada
  final Function(int) onTap; // callback para clique nos ícones

  const BottomNavbar({
    super.key,
    this.indexAtivo = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tamanhoIcone = 24.0;
    final tamanhoLabel = 12.0;

    // lista de abas com ícone e label
    final List<Map<String, dynamic>> abas = [
      {
        'icone': Icons.folder, // pode usar seu PNG se quiser
        'label': 'Documentos',
      },
      {
        'icone': Icons.share,
        'label': 'Compartilhar',
      },
      {
        'icone': Icons.delete,
        'label': 'Lixeira',
      },
      {
        'icone': Icons.settings,
        'label': 'Configurações',
      },
    ];

    return Container(
      width: double.infinity,
      height: 64,
      color: const Color(0xFFE9EFF1), // fundo
      child: Row(
        children: List.generate(abas.length, (index) {
          final ativo = index == indexAtivo;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
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
