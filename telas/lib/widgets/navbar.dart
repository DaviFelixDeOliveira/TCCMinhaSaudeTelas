import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final bool mostrarIcones;

  const Navbar({super.key, this.mostrarIcones = true});

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
              if (mostrarIcones)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              Image.asset(
                'assets/images/LogoMinhaSaude.png',
                width: size.width * 0.25, // largura proporcional
                height: size.height * 0.05, // altura proporcional
                fit: BoxFit.contain,
              ),
            ],
          ),

          if (mostrarIcones)
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // ação dos 3 pontinhos aqui
              },
            ),
        ],
      ),
    );
  }
}
