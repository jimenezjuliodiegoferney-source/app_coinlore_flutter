import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/crypto_provider.dart';

class RefreshButton extends ConsumerStatefulWidget {
  const RefreshButton({super.key});

  @override
  ConsumerState<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends ConsumerState<RefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Evitar doble tap
    if (ref.read(isRefreshingProvider)) return;

    // Marcar como refrescando
    ref.read(isRefreshingProvider.notifier).state = true;

    // Iniciar animación de rotación infinita
    _controller.repeat();

    try {
      // Refrescar datos
      await ref.read(cryptoListNotifierProvider.notifier).refresh();

      // Mostrar SnackBar de confirmación
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Datos actualizados'),
              ],
            ),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Mostrar error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text('Error al actualizar: $e'),
              ],
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // Detener animación
      if (mounted) {
        _controller.stop();
        _controller.reset();
        ref.read(isRefreshingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRefreshing = ref.watch(isRefreshingProvider);

    return IconButton(
      icon: RotationTransition(
        turns: _controller,
        child: const Icon(Icons.refresh),
      ),
      onPressed: isRefreshing ? null : _onRefresh,
    );
  }
}
