import 'package:flutter/material.dart';
import '../../../widgets/navbar.dart';
import '../../../widgets/bottom_navbar.dart';

class EditarCodigo extends StatefulWidget {
  final String telefone;

  const EditarCodigo({
    super.key,
    required this.telefone,
  });

  @override
  State<EditarCodigo> createState() => _EditarCodigoState();
}

class _EditarCodigoState extends State<EditarCodigo> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  
  @override
  void initState() {
    super.initState();
    
    // Configurar listeners para mover o foco entre os campos
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < _controllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        
        // Se apagar um dígito, voltar para o campo anterior
        if (_controllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
      });
    }
  }
  
  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _verificarCodigo() {
    // Verificar se todos os campos estão preenchidos
    bool todosPreenchidos = true;
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        todosPreenchidos = false;
        break;
      }
    }
    
    if (todosPreenchidos) {
      // Lógica para verificar o código
      // Aqui você pode implementar a validação do código
      Navigator.pop(context, true); // Retorna true indicando sucesso
    } else {
      // Mostrar mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os dígitos do código.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Navbar(
          mostrarImagem: false,
          mostrarIconeVoltar: true,
          titulo: 'Verificar Telefone',
          onVoltarPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            
            // Texto informativo
            Text(
              'Digite o código de 6 dígitos foi enviado para o número ${widget.telefone}',
              style: const TextStyle(
                color: Color(0xFF3F484B),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Título "Código"
            const Text(
              'Código',
              style: TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Campos de entrada do código
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 48,
                  height: 48,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFBFC8CB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF006879)),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                      }
                    },
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 16),
            
            // Link "Não recebeu o código?"
            Center(
              child: GestureDetector(
                onTap: () {
                  // Lógica para reenviar o código
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Código reenviado!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  'Não recebeu o código?',
                  style: TextStyle(
                    color: Color(0xFF006879),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            // Botões Voltar e Verificar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão Voltar
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5FAFC),
                      foregroundColor: const Color(0xFF006879),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: const BorderSide(color: Color(0xFF006879)),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Botão Verificar
                Expanded(
                  child: ElevatedButton(
                    onPressed: _verificarCodigo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006879),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Verificar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}