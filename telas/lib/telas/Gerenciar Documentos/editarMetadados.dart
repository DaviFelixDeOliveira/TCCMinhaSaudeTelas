import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/bottom_navbar.dart';

class EditarMetadados extends StatefulWidget {
  final Map<String, dynamic> documento;

  const EditarMetadados({super.key, required this.documento});

  @override
  State<EditarMetadados> createState() => _EditarMetadadosState();
}

class _EditarMetadadosState extends State<EditarMetadados> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _pacienteController;
  late TextEditingController _medicoController;
  late TextEditingController _tipoController;
  late TextEditingController _dataDocumentoController;
  late TextEditingController _dataAdicaoController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.documento['titulo'] ?? '');
    _pacienteController = TextEditingController(text: widget.documento['paciente'] ?? '');
    _medicoController = TextEditingController(text: widget.documento['medico'] ?? '');
    _tipoController = TextEditingController(text: widget.documento['tipo'] ?? '');
    _dataDocumentoController = TextEditingController(text: widget.documento['dataDocumento'] ?? '');
    _dataAdicaoController = TextEditingController(text: widget.documento['dataAdicao'] ?? '');
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _pacienteController.dispose();
    _medicoController.dispose();
    _tipoController.dispose();
    _dataDocumentoController.dispose();
    _dataAdicaoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'titulo': _tituloController.text,
        'paciente': _pacienteController.text,
        'medico': _medicoController.text,
        'tipo': _tipoController.text,
        'dataDocumento': _dataDocumentoController.text,
        'dataAdicao': _dataAdicaoController.text,
      });
    }
  }

  void _cancelar() {
    Navigator.pop(context);
  }

  Widget _buildCampoEdicao({
    required String label,
    required TextEditingController controller,
    bool isDateField = false,
  }) {
    return Container(
      height: 70, // Aumentado para maior altura
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 70, // Aumentado para maior altura
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.5,
                  color: Color(0xFF70797B),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: isDateField ? 50 : 16, top: 20),
              child: TextFormField(
                controller: controller,
                style: const TextStyle(
                  color: Color(0xFF171C1E),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.50,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: '',
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              color: const Color(0xFFF5FAFC),
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF3F484B),
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                  letterSpacing: 0.40,
                ),
              ),
            ),
          ),
          if (isDateField)
            Positioned(
              right: 12,
              top: 22,
              child: IconButton(
                icon: const Icon(Icons.calendar_today, size: 24, color: Color(0xFF006879)),
                onPressed: () => _selectDate(context, controller),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFC),
      body: Column(
        children: [
          Navbar(
            mostrarImagem: false,
            mostrarIconeVoltar: true,
            titulo: 'Editar Metadados',
            tipoIconeDireito: NavbarIcon.nenhum,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    _buildCampoEdicao(
                      label: 'Título',
                      controller: _tituloController,
                    ),
                    _buildCampoEdicao(
                      label: 'Nome do Paciente',
                      controller: _pacienteController,
                    ),
                    _buildCampoEdicao(
                      label: 'Nome do Médico',
                      controller: _medicoController,
                    ),
                    _buildCampoEdicao(
                      label: 'Tipo de Documento',
                      controller: _tipoController,
                    ),
                    _buildCampoEdicao(
                      label: 'Data do Documento',
                      controller: _dataDocumentoController,
                      isDateField: true,
                    ),
                    _buildCampoEdicao(
                      label: 'Data de Adição',
                      controller: _dataAdicaoController,
                      isDateField: true,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _cancelar,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFCEE7EE),
                              foregroundColor: const Color(0xFF334A50),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              side: BorderSide.none,
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _salvarAlteracoes,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF006879),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                fontSize: 16,
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}