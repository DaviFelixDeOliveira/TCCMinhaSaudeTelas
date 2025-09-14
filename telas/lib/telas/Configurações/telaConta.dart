import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';

class TelaConta extends StatefulWidget {
  const TelaConta({super.key});

  @override
  State<TelaConta> createState() => _TelaContaState();
}

class _TelaContaState extends State<TelaConta> {
  bool contaGoogleVinculada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSecaoContaGoogle(),
                const SizedBox(height: 24),
                _buildLabelAcoes(),
                const SizedBox(height: 16),
                _buildBotoesAcoes(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Container da conta Google ---
  Widget _buildSecaoContaGoogle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5FAFC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        children: [
          // Logo Google
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/GoogleLogo.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contaGoogleVinculada
                      ? 'Sua conta Google está vinculada.'
                      : 'Você não tem uma conta Google vinculada.',
                  style: const TextStyle(
                    color: Color(0xFF171C1E),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    if (contaGoogleVinculada) {
                      _mostrarDialogoDesvincularGoogle(context);
                    } else {
                      _mostrarDialogoVincularGoogle(context);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        contaGoogleVinculada ? 'Desvincular' : 'Vincular',
                        style: const TextStyle(
                          color: Color(0xFF004E5C),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.link,
                        color: const Color(0xFF004E5C),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Label Ações ---
  Widget _buildLabelAcoes() {
    return const SizedBox(
      width: 380,
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
    );
  }

  // --- Botões Encerrar Sessão e Excluir Conta ---
  Widget _buildBotoesAcoes() {
    return Column(
      children: [
        _buildBotaoCustom(
          texto: 'Encerrar Sessão',
          icone: Icons.exit_to_app,
          corFundo: const Color(0xFF006879),
          onPressed: () => _mostrarDialogoEncerrarSessao(context),
        ),
        const SizedBox(height: 12),
        _buildBotaoCustom(
          texto: 'Excluir Conta',
          icone: Icons.delete_outline,
          corFundo: const Color(0xFFBA1A1A),
          onPressed: () => _mostrarDialogoExcluirConta(context),
        ),
      ],
    );
  }

  Widget _buildBotaoCustom({
    required String texto,
    required IconData icone,
    required Color corFundo,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: corFundo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icone, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        texto,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Diálogo Encerrar Sessão ---
  void _mostrarDialogoEncerrarSessao(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Encerrar Sessão',
                          style: TextStyle(
                            color: Color(0xFF171C1E),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Tem certeza que deseja encerrar a sessão? Você terá que fazer login novamente caso faça isso.',
                          style: TextStyle(
                            color: Color(0xFF3F484B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Color(0xFF4B6268),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Lógica de logout
                            },
                            child: const Text(
                              'Encerrar Sessão',
                              style: TextStyle(
                                color: Color(0xFFBA1A1A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Diálogo Excluir Conta ---
  void _mostrarDialogoExcluirConta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFBA1A1A),
                        size: 40,
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Excluir Conta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF171C1E),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 264,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Ao confirmar a exclusão da sua conta, ocorrerá o seguinte:\n',
                                style: TextStyle(
                                  color: Color(0xFF3F484B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.43,
                                  letterSpacing: 0.25,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Sua conta será imediatamente desativada e não poderá mais ser acessada.\nTodos os seus dados, documentos e configurações serão marcados para exclusão permanente.\nVocê terá até 30 dias para reativar sua conta. Após esse prazo, a exclusão será irreversível.\nPara reativar sua conta, entre em contato com nossa equipe de suporte',
                                style: TextStyle(
                                  color: Color(0xFF3F484B),
                                  fontSize: 14,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFBFC8CB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Color(0xFF3F484B),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Lógica de exclusão
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBA1A1A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text(
                              'Excluir minha Conta',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Diálogo Vincular Google ---
  void _mostrarDialogoVincularGoogle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Vincular Google',
                          style: TextStyle(
                            color: Color(0xFF171C1E),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Você tem certeza que deseja vincular sua conta Google. Essa ação não pode ser desfeita.',
                          style: TextStyle(
                            color: Color(0xFF3F484B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Color(0xFF4B6268),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                contaGoogleVinculada = true;
                              });
                            },
                            child: const Text(
                              'Vincular',
                              style: TextStyle(
                                color: Color(0xFF006879),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Diálogo Desvincular Google ---
  void _mostrarDialogoDesvincularGoogle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Desvincular Google',
                          style: TextStyle(
                            color: Color(0xFF171C1E),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 264,
                        child: Text(
                          'Você tem certeza que deseja desvincular sua conta Google?',
                          style: TextStyle(
                            color: Color(0xFF3F484B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Color(0xFF4B6268),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                contaGoogleVinculada = false;
                              });
                            },
                            child: const Text(
                              'Desvincular',
                              style: TextStyle(
                                color: Color(0xFFBA1A1A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}