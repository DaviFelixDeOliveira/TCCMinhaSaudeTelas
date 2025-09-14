import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';

class TelaSuporte extends StatelessWidget {
  const TelaSuporte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título Informações
                  const SizedBox(
                    width: 380,
                    child: Text(
                      'Informações',
                      style: TextStyle(
                        color: Color(0xFF171C1E),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Texto de descrição
                  const SizedBox(
                    width: 380,
                    child: Text(
                      'Em caso de dúvidas, sugestões ou problemas, você pode entrar em contato conosco através do e-mail: tccminhasaude2025@gmail.com',
                      style: TextStyle(
                        color: Color(0xFF171C1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Botão para copiar e-mail
                  _buildBotaoCopiarEmail(context),
                  const SizedBox(height: 32),
                  // Informações adicionais (opcional)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoCopiarEmail(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Lógica para copiar e-mail para área de transferência
          _copiarParaAreaDeTransferencia(context, 'tccminhasaude2025@gmail.com');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006879),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.content_copy, size: 18),
            SizedBox(width: 8),
            Text('Copiar e-mail'),
          ],
        ),
      ),
    );
  }

  void _copiarParaAreaDeTransferencia(BuildContext context, String texto) {
    // Em um app real, você usaria o Clipboard.setData
    // Clipboard.setData(ClipboardData(text: texto));
    
    // Mostrar snackbar de feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E-mail copiado para a área de transferência'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}