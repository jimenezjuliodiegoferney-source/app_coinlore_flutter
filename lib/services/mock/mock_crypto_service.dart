import 'mock_data.dart';
import '../../models/crypto_entity.dart';

class MockCryptoService {
  // Simula obtener lista de cryptos con paginación
  Future<List<CryptoEntity>> getCryptos({int start = 0, int limit = 10}) async {
    print('🟣 MockCryptoService.getCryptos - start: $start, limit: $limit');
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));

    final allCryptos = MockData.cryptos;
    final end = (start + limit) > allCryptos.length
        ? allCryptos.length
        : start + limit;

    return allCryptos.sublist(start, end);
  }

  // Simula obtener detalle de una crypto
  Future<Map<String, dynamic>> getCoinDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.getCoinDetail(id);
  }

  // Simula búsqueda
  Future<List<CryptoEntity>> searchCryptos(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.searchCryptos(query);
  }

  // Simula obtener todas las cryptos (para búsqueda)
  Future<List<CryptoEntity>> getAllCryptos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.cryptos;
  }
}
