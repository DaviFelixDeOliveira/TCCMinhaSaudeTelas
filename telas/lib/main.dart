import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'telas/Listar Arquivos/listarArquivos.dart';
import 'telas/Compartilhamento/codigosCompartilhamento.dart';
import 'telas/Lixeira/listarDocumentosApagados.dart';
import 'widgets/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

/// Widget base da aplicação
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Minha Saúde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006879)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

/// GoRouter com ShellRoute para manter a BottomNavbar
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    /// Shell com BottomNavbar
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavbar(
            indexAtivo: _getIndex(state),
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/');
                  break;
                case 1:
                  context.go('/compartilhar');
                  break;
                case 2:
                  context.go('/lixeira');
                  break;
                case 3:
                  context.go('/configuracoes');
                  break;
              }
            },
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'documentos',
          builder: (context, state) => const ListarArquivos(),
        ),
        GoRoute(
          path: '/compartilhar',
          name: 'compartilhar',
          builder: (context, state) => const CodigosCompartilhamento(),
        ),
        GoRoute(
          path: '/lixeira',
          name: 'lixeira',
          builder: (context, state) =>
              const ListarDocumentosApagados(documentos: []),
        ),
        GoRoute(
          path: '/configuracoes',
          name: 'configuracoes',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Tela de Configurações')),
          ),
        ),
      ],
    ),
  ],
);

/// Função auxiliar para ativar o índice correto da navbar
int _getIndex(GoRouterState state) {
  final location = state.uri.toString(); // substitui state.location
  if (location.startsWith('/compartilhar')) return 1;
  if (location.startsWith('/lixeira')) return 2;
  if (location.startsWith('/configuracoes')) return 3;
  return 0; // documentos
}
