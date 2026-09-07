import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_detail_model.dart';
import '../services/mock/mock_detail_service.dart';
import 'crypto_provider.dart';

final mockDetailServiceProvider = Provider<MockDetailService>((ref) {
  return MockDetailService();
});

// Estado del detalle
final detailStateProvider = StateProvider<AsyncValue<CryptoDetailEntity>>(
  (ref) => const AsyncValue.loading(),
);

// Acción para cargar detalle de una moneda
final loadDetailProvider = FutureProvider.family<void, String>((ref, id) async {
  // Poner en estado de carga
  ref.read(detailStateProvider.notifier).state = const AsyncValue.loading();

  try {
    final service = ref.watch(mockDetailServiceProvider);
    final detail = await service.getCoinDetail(id);
    ref.read(detailStateProvider.notifier).state = AsyncValue.data(detail);
  } catch (error, stack) {
    ref.read(detailStateProvider.notifier).state = AsyncValue.error(
      error,
      stack,
    );
    rethrow;
  }
});

// Provider para acceder al detalle desde la UI
final detailProvider = Provider<AsyncValue<CryptoDetailEntity>>((ref) {
  return ref.watch(detailStateProvider);
});
