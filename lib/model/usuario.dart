class Usuario {
  final int id;
  final String nome;
  final String email;
  final String cidade;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.cidade,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final endereco = json['address'] as Map<String, dynamic>;

    return Usuario(
      id: json['id'],
      nome: json['name'],
      email: json['email'],
      cidade: endereco['city'],
    );
  }
}