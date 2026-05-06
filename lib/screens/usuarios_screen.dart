import 'package:flutter/material.dart';
import '../model/usuario.dart';
import '../services/api_service.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final api = ApiService();

  List<Usuario> usuarios = [];
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  Future<void> carregarUsuarios() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      usuarios = await api.buscarUsuarios();
    } catch (e) {
      erro = 'Erro ao carregar usuários';
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔄 LOADING
    if (carregando) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text("Carregando usuários..."),
            ],
          ),
        ),
      );
    }

    // ❌ ERRO
    if (erro != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 60, color: Colors.red),
              const SizedBox(height: 10),
              Text(erro!),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: carregarUsuarios,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    // ✅ SUCESSO
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: carregarUsuarios,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: usuarios.length,

          itemBuilder: (context, index) {
            final u = usuarios[index];

            return Card(
              color: Colors.white.withOpacity(0.95),

              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

              elevation: 6,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.all(18),

                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF1565C0),

                  child: Text(
                    u.nome[0],

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                title: Text(
                  u.nome,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF1565C0),
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email, size: 16, color: Colors.grey),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              u.email,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            size: 16,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 6),

                          Text(u.cidade, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),

                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
