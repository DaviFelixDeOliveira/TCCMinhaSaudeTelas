import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/navbar.dart';
import 'widgets/bottom_navbar.dart';
import 'telas/Compartilhamento/selecionarDocumentos.dart';

void main() {
  runApp(const MaterialApp(
    home: ListarCompartilhamento(),
    debugShowCheckedModeBanner: false,
  ));
}

class ListarCompartilhamento extends StatefulWidget {
  const ListarCompartilhamento({super.key});

  @override
  State<ListarCompartilhamento> createState() =>
      _ListarCompartilhamentoState();
}

class _ListarCompartilhamentoState extends State<ListarCompartilhamento> {
  final List<Map<String, String>> codigos = [
    {'codigo': 'IMBLI7S8QO', 'validade': '02-06-2025 | 18:00'}
  ];

  void mostrarSnackbar(String mensagem) {
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
            Expanded(
              child: Text(
                mensagem,
                style: const TextStyle(
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
              onPressed: () => scaffoldMessenger.hideCurrentSnackBar(),
              icon: const Icon(Icons.close, size: 24, color: Color(0xFFECF2F4)),
              tooltip: 'Fechar',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _irParaCriarCodigo() async {
    final novoCodigo = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const SelecionarDocumentos()),
    );

    if (novoCodigo != null) {
      setState(() {
        codigos.insert(0, novoCodigo);
      });
    }
  }

  void _excluirCodigoDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final codigo = codigos[index]['codigo'] ?? '';
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
                children: [
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Icon(Icons.delete_outline,
                          size: 32, color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Desativar Código',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF171C1E),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Tem certeza que deseja desativar o código ',
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
                          text: codigo,
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
                          text: '? Essa ação não pode ser desfeita.',
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
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 48,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFFBFC8CB)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Center(
                                child: Text(
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
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                codigos.removeAt(index);
                              });
                              Navigator.pop(context);
                              mostrarSnackbar(
                                  'Compartilhamento removido com sucesso!');
                            },
                            child: Container(
                              height: 48,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFBA1A1A),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Desativar',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(Map<String, String> item) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['codigo']!,
                      style: const TextStyle(
                        color: Color(0xFF171C1E),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                        letterSpacing: 0.15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                            ClipboardData(text: item['codigo']!));
                        mostrarSnackbar(
                            'Código copiado para a área de transferência');
                      },
                      child: const Icon(
                        Icons.copy,
                        size: 16,
                        color: Color(0xFF3F484B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Valido até ${item['validade']}',
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
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              final index = codigos.indexOf(item);
              _excluirCodigoDialog(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNovoCodigoButton() {
    return GestureDetector(
      onTap: _irParaCriarCodigo,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFA9EDFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Color(0xFF004E5C)),
              SizedBox(width: 8),
              Text(
                'Novo Código',
                style: TextStyle(
                  color: Color(0xFF004E5C),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Navbar(
            mostrarIconeVoltar: true,
            mostrarIconeMais: false,
            mostrarImagem: true,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 380,
              child: Text(
                'Códigos de Compartilhamento',
                style: TextStyle(
                  color: Color(0xFF171C1E),
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.27,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: codigos.isEmpty
                  ? const Center(child: Text("Nenhum código gerado ainda."))
                  : ListView.separated(
                      itemCount: codigos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildCard(codigos[index]);
                      },
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildNovoCodigoButton(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        onTap: (index) {},
      ),
    );
  }
}
