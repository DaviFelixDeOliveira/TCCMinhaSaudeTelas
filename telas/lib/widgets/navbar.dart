import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final bool mostrarImagem;           // Mostra logo?
  final bool mostrarIconeVoltar;      // Mostra seta?
  final bool mostrarIconeMais;        // Mostra três pontinhos?
  final String? titulo;               // Texto se imagem não for mostrada

  const Navbar({
    super.key,
    this.mostrarImagem = false,
    this.mostrarIconeVoltar = false,
    this.mostrarIconeMais = false,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.01,
      ),
      color: const Color(0xFFE9EFF1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (mostrarIconeVoltar)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              mostrarImagem
                  ? Image.asset(
                      'assets/images/LogoMinhaSaude.png',
                      width: size.width * 0.25,
                      height: size.height * 0.05,
                      fit: BoxFit.contain,
                    )
                  : Text(
                      titulo ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF171C1E),
                      ),
                    ),
            ],
          ),

          // --- Lado Direito: Ícone de opções ---
          if (mostrarIconeMais)
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // ação dos três pontinhos
              },
            ),
        ],
      ),
    );
  }
}
