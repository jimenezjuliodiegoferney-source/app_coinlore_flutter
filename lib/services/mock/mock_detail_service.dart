import '../../models/crypto_detail_model.dart';
import 'mock_data.dart';

class MockDetailService {
  Future<CryptoDetailEntity> getCoinDetail(String id) async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));

    // Buscar el crypto en los datos mock
    final crypto = MockData.cryptos.firstWhere(
      (c) => c.id == id,
      orElse: () => MockData.cryptos.first,
    );

    // Crear un ticker detail mock
    final ticker = TickerDetailModel(
      id: crypto.id,
      symbol: crypto.symbol,
      name: crypto.name,
      rank: crypto.rank,
      priceUsd: crypto.priceUsd.toString(),
      percentChange24h: crypto.percentChange24h.toString(),
      percentChange1h: (crypto.percentChange24h * 0.5).toString(),
      percentChange7d: crypto.percentChange7d.toString(),
      marketCapUsd: crypto.marketCapUsd.toString(),
      volume24: crypto.volume24.toString(),
      csupply: (crypto.marketCapUsd / crypto.priceUsd).toStringAsFixed(0),
      tsupply: (crypto.marketCapUsd / crypto.priceUsd * 1.2).toStringAsFixed(0),
      msupply: (crypto.marketCapUsd / crypto.priceUsd * 1.5).toStringAsFixed(0),
    );

    // Crear un info mock
    final info = CoinInfoModel(
      id: crypto.id,
      symbol: crypto.symbol,
      name: crypto.name,
      website: 'https://${crypto.name.toLowerCase()}.org',
      twitter: 'https://twitter.com/${crypto.symbol.toLowerCase()}',
      explorer: 'https://explorer.${crypto.name.toLowerCase()}.com',
      logo:
          'https://c2.coinlore.com/img/25x25/${crypto.name.toLowerCase()}.png',
      ath: crypto.priceUsd * 1.5,
      athDate: '2024-03-14',
      startDate: '2010-01-01',
      platform: crypto.symbol == 'BTC' ? 'Native' : 'Ethereum',
    );

    return CryptoDetailEntity(ticker: ticker, info: info);
  }
}
