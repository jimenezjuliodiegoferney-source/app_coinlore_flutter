import 'package:coin_lore_app/views/crypto_detail_secreen.dart';
import 'package:coin_lore_app/widgets/search_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/crypto_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/crypto_table_header.dart';
import '../widgets/crypto_table_row.dart';

class CryptoListScreen extends ConsumerStatefulWidget {
  const CryptoListScreen({super.key});

  @override
  ConsumerState<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends ConsumerState<CryptoListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    // ✅ Cargar datos iniciales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cryptoListNotifierProvider.notifier).loadInitialData();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    await ref.read(cryptoListNotifierProvider.notifier).loadMoreData();

    _isLoadingMore = false;
  }

  Future<void> _refreshData() async {
    await ref.read(cryptoListNotifierProvider.notifier).refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cryptos = ref.watch(cryptoListNotifierProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final error = ref.watch(errorProvider);
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text(
          'CoinLore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(settingsProvider.notifier).state = ref
                  .read(settingsProvider)
                  .copyWith(
                    themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
                  );
            },
          ),
          IconButton(
            icon: const Text('USD'),
            onPressed: () {
              // TODO: Implementar selector de moneda
            },
          ),
          IconButton(
            icon: const Text('EN'),
            onPressed: () {
              // TODO: Implementar selector de idioma
            },
          ),

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // ✅ ABRIR EL MODAL
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SearchModal(),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Precio de criptomonedas hoy + cotización',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: $error',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _refreshData,
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const CryptoTableHeader(),
                        Expanded(
                          child: isLoading && cryptos.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 16),
                                      Text('Cargando datos...'),
                                    ],
                                  ),
                                )
                              : cryptos.isEmpty
                              ? const Center(
                                  child: Text('No hay datos disponibles'),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: cryptos.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == cryptos.length) {
                                      if (_isLoadingMore) {
                                        return const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }

                                    final crypto = cryptos[index];
                                    return CryptoTableRow(
                                      rank: index + 1,
                                      crypto: crypto,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CryptoDetailScreen(
                                                  crypto: crypto,
                                                ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
