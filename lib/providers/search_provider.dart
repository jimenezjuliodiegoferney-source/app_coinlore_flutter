import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_entity.dart';
import '../services/search_history_service.dart';
import 'crypto_provider.dart'; // ✅ IMPORTANTE: Para mockCryptoServiceProvider

final searchHistoryServiceProvider = Provider<SearchHistoryService>((ref) {
  return SearchHistoryService();
});

// Estado de la búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// ✅ CORREGIDO: Resultados de búsqueda (filtrados en tiempo real)
final searchResultsProvider = Provider<List<CryptoEntity>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final allCryptosAsync = ref.watch(allCryptosProvider);

  if (query.trim().isEmpty) {
    return [];
  }

  final lowerQuery = query.toLowerCase().trim();

  // ✅ Usar when para manejar los estados del FutureProvider
  return allCryptosAsync.when(
    data: (allCryptos) {
      return allCryptos
          .where(
            (crypto) =>
                crypto.name.toLowerCase().contains(lowerQuery) ||
                crypto.symbol.toLowerCase().contains(lowerQuery),
          )
          .toList();
    },
    loading: () => [], // Mientras carga, no hay resultados
    error: (error, stack) => [], // Si hay error, no hay resultados
  );
});

// Todos los cryptos (para búsqueda)
final allCryptosProvider = FutureProvider<List<CryptoEntity>>((ref) async {
  final service = ref.watch(mockCryptoServiceProvider); // ✅ Ahora funciona
  return await service.getAllCryptos();
});

// Historial de búsqueda
final searchHistoryProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(searchHistoryServiceProvider);
  return await service.getHistory();
});

// Acción para agregar al historial
final addToHistoryProvider = FutureProvider.family<void, String>((
  ref,
  query,
) async {
  final service = ref.watch(searchHistoryServiceProvider);
  await service.addToHistory(query);
});

// Acción para limpiar historial
final clearHistoryProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(searchHistoryServiceProvider);
  await service.clearHistory();
});
