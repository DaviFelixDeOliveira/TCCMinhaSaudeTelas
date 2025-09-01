import 'package:flutter/material.dart';
import 'widgets/navbar.dart';

// --- Widget do item de documento com novo estilo ---
class DocumentoItem extends StatelessWidget {
  final String titulo;
  final String iconePath;

  const DocumentoItem({super.key, required this.titulo, required this.iconePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Image.asset(
              iconePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 112,
            child: Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.33,
                letterSpacing: 0.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Tela de documentos em Grid ---
class TelaDocumentos extends StatelessWidget {
  final List<String> documentos;
  final bool mostrarIcones;

  const TelaDocumentos({
    super.key,
    required this.documentos,
    this.mostrarIcones = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Navbar(mostrarIcones: mostrarIcones),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Documentos',
              style: TextStyle(
                color: Color(0xFF171C1E),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.27,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: documentos
                    .map((titulo) => DocumentoItem(
                          titulo: titulo,
                          iconePath: 'assets/images/3266a812-01e3-4446-a273-abe2059c2640.png',
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Tela Lixeira ---
class TelaLixeira extends StatelessWidget {
  const TelaLixeira({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Navbar(mostrarIcones: true),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              'Lixeira',
              style: TextStyle(
                color: const Color(0xFF171C1E),
                fontSize: size.width * 0.055,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.27,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: size.height * 0.015),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.005,
                      ),
                      leading: Icon(
                        Icons.insert_drive_file,
                        size: size.width * 0.06,
                      ),
                      title: Text(
                        'Documento ${index + 1}',
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      subtitle: Text(
                        'Descrição do documento',
                        style: TextStyle(fontSize: size.width * 0.035),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.restore_outlined,
                              size: size.width * 0.06,
                              color: Colors.green,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: size.width * 0.06,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Main ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaDocumentos(
        documentos: [
          'Tomografia da Jaqueline Souza',
          'Hemograma do Marcos Lima\n02-2020',
          'Hemograma da Ana Beatriz Rocha\n03-2020',
          'Haldol Daniel',
        ],
      ),
    );
  }
}
