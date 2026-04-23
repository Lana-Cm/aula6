class AuthService {
  // Este método finge que vai na internet conferir o login
  // Usamos String? pois se o login falhar, o resultado será null (nulo)
  Future<String?> login(String email, String senha) async {
    // 1. Espera 2 segundos (Simula o tempo de resposta da internet)
    // O 'await' avisa o app: "pode continuar funcionando, mas pare esta função aqui até terminar"
    await Future.delayed(const Duration(seconds: 2));

    // 2. Confere se os dados estão certos
    if (email == "aluno@etec.sp.gov.br" && senha == "123456") {
      return "sucesso_token_123"; // Retorna o 'crachá' (Token)
    }

    return null; // Retorna nulo se o login falhar
  }
}
