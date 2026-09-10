import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_entity.dart';
import '../services/mock/mock_crypto_service.dart';

final mockCryptoServiceProvider = Provider<MockCryptoService>((ref) {
  return MockCryptoService();
});

// ✅ StateNotifier para manejar la lista con scroll infinito
class CryptoListNotifier extends StateNotifier<List<CryptoEntity>> {
  final MockCryptoService _service;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  CryptoListNotifier(this._service) : super([]);

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadInitialData() async {
    if (_isLoading) return;
    _isLoading = true;
    state = [];
    _currentPage = 0;
    _hasMore = true;

    await _loadData();
    _isLoading = false;
  }

  Future<void> loadMoreData() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    await _loadData();
    _isLoading = false;
  }

  Future<void> _loadData() async {
    try {
      final cryptos = await _service.getCryptos(start: _currentPage, limit: 20);

      if (cryptos.isEmpty) {
        _hasMore = false;
      } else {
        state = [...state, ...cryptos];
        _currentPage += 20;
      }
    } catch (e) {
      // Manejar error
    }
  }

  Future<void> refresh() async {
    await loadInitialData();
  }
}

// ✅ Provider del notifier
final cryptoListNotifierProvider =
    StateNotifierProvider<CryptoListNotifier, List<CryptoEntity>>((ref) {
      final service = ref.watch(mockCryptoServiceProvider);
      return CryptoListNotifier(service);
    });

// ✅ Provider separado para el estado de carga
final isLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(cryptoListNotifierProvider.notifier);
  return (notifier as CryptoListNotifier).isLoading;
});

// ✅ Provider para errores
final errorProvider = StateProvider<String?>((ref) => null);

// ✅ NUEVO: Provider para el estado de refresco
final isRefreshingProvider = StateProvider<bool>((ref) => false);
