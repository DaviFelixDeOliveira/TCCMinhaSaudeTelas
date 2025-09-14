import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';
import 'editarNome.dart';
import 'editarData.dart';
import 'telaConta.dart';
import 'telaSuporte.dart';
import 'Editar Telefone/editarTelefone.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  int abaSelecionada = 0; // 0: Geral, 1: Conta, 2: Suporte

  bool modoEscuroAtivo = false;

  // Valores atuais do usuário
  String nome = 'Ana';
  String sobrenome = 'Beatriz Rocha';
  String cpf = '123.456.789-00';
  String email = 'ana.beatriz@email.com';
  String dataNascimento = '08/02/1995';
  String telefone = '(11) 91234-5678';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Navbar(
            mostrarImagem: true,
            mostrarIconeVoltar: false,
            tipoIconeDireito: NavbarIcon.nenhum,
          ),
          _buildAbas(),
          _buildDivisor(),
          Expanded(child: _buildConteudoAba()),
        ],
      ),
    );
  }

  Widget _buildAbas() {
    return Container(
      height: 48,
      color: const Color(0xFFF5FAFC),
      child: Row(
        children: [
          _buildAba("Geral", 0),
          _buildAba("Conta", 1),
          _buildAba("Suporte", 2),
        ],
      ),
    );
  }

  Widget _buildAba(String titulo, int index) {
    final selecionada = abaSelecionada == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            abaSelecionada = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(
                color: selecionada
                    ? const Color(0xFF006879)
                    : const Color(0xFF3F484B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
              ),
            ),
            if (selecionada)
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF006879),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivisor() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFBFC8CB), width: 1)),
      ),
    );
  }

  Widget _buildConteudoAba() {
    switch (abaSelecionada) {
      case 0:
        return _buildAbaGeral();
      case 1:
      return const TelaConta();
            case 2:
      return const TelaSuporte(); 
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAbaGeral() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(
          width: 380,
          child: Text(
            'Informações',
            style: TextStyle(
              color: Color(0xFF171C1E),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildDivisor(),
        const SizedBox(height: 8),
        _buildCampo('CPF', cpf, false),
        _buildDivisor(),
        const SizedBox(height: 8),
        _buildCampo('E-mail', email, false),
        _buildDivisor(),
        const SizedBox(height: 8),
        _buildCampo(
          'Nome completo',
          '$nome $sobrenome',
          true,
          onEditar: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditarNome(nomeAtual: nome, sobrenomeAtual: sobrenome),
              ),
            ).then((valor) {
              if (valor != null && valor is Map<String, String>) {
                setState(() {
                  nome = valor['nome']!;
                  sobrenome = valor['sobrenome']!;
                });
              }
            });
          },
        ),
        _buildDivisor(),
        const SizedBox(height: 8),
        _buildCampoDataNascimento(),
        _buildDivisor(),
        const SizedBox(height: 8),
        _buildCampo(
          'Telefone',
          telefone,
          true,
          onEditar: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditarTelefone(telefoneAtual: telefone),
              ),
            ).then((novoTelefone) {
              if (novoTelefone != null && novoTelefone is String) {
                setState(() {
                  telefone = novoTelefone;
                });
              }
            });
          },
        ),
        const SizedBox(height: 16),
        _buildBotaoExportarDados(),
        const SizedBox(height: 24),
        _buildOpcaoTema(),
       // _buildDivisor(),
        const SizedBox(height: 8),
       // _buildOpcaoPrivacidade('Política de Privacidade'),
       // _buildDivisor(),
        const SizedBox(height: 8),
       // _buildOpcaoPrivacidade('Termos de Uso'),
      //  _buildDivisor(),
      ],
    );
  }

  // Campo Data de Nascimento com botão Editar
  Widget _buildCampoDataNascimento() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data de nascimento',
                  style: TextStyle(
                    color: Color(0xFF3F484B),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dataNascimento,
                  style: const TextStyle(
                    color: Color(0xFF171C1E),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarData(dataAtual: dataNascimento),
                  ),
                ).then((novaData) {
                  if (novaData != null && novaData is String) {
                    setState(() {
                      dataNascimento = novaData;
                    });
                  }
                });
              },
              child: Row(
                children: const [
                  Text(
                    'Editar',
                    style: TextStyle(
                      color: Color(0xFF171C1E),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF171C1E),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampo(
    String titulo,
    String valor,
    bool editavel, {
    VoidCallback? onEditar,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF3F484B),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    color: Color(0xFF171C1E),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
          if (editavel)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: onEditar,
                child: Row(
                  children: const [
                    Text(
                      'Editar',
                      style: TextStyle(
                        color: Color(0xFF171C1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xFF171C1E),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBotaoExportarDados() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF006879),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                size: 40,
                                color: Color(0xFF006879),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Exportar Dados',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF171C1E),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '• Seus dados de conta e documentos serão incluídos na exportação.\n'
                                '• Os dados serão enviados para o seu e-mail cadastrado em um arquivo para download.\n'
                                '• O link para download expirará 24 horas após o recebimento. O processo pode levar algum tempo.\n'
                                '• Você receberá um e-mail quando estiver pronto.\n\n'
                                'Para continuar, clique em "Confirmar Exportar" abaixo.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF3F484B),
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFF5FAFC,
                                        ),
                                        foregroundColor: const Color(
                                          0xFF334A50,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        side: const BorderSide(
                                          color: Color(0xFFCEE7EE),
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        ); // fecha o dialog
                                        _mostrarSnackBarExportacao(
                                          context,
                                        ); // mostra a snackbar
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF006879,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Confirmar Exportar',
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
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.file_download, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Exportar Dados',
                        style: TextStyle(
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
        ],
      ),
    );
  }

  void _mostrarSnackBarExportacao(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Container(
        width: 344,
        height: 68,
        padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
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
            ),
          ],
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Seus dados serão enviados por e-mail dentro de 24 horas',
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
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildOpcaoTema() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Modo Escuro',
            style: TextStyle(
              color: Color(0xFF171C1E),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              modoEscuroAtivo = !modoEscuroAtivo;
            });
          },
          child: Container(
            width: 52,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: ShapeDecoration(
              color: modoEscuroAtivo
                  ? const Color(0xFF006879)
                  : const Color(0xFFDEE3E5),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFF70797B)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisAlignment: modoEscuroAtivo
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOpcaoPrivacidade(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFF171C1E),
          ),
        ],
      ),
    );
  }
}
