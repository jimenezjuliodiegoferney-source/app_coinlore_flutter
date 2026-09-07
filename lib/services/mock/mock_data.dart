import '../../models/crypto_entity.dart';

class MockData {
  static List<CryptoEntity> get cryptos => [
    CryptoEntity(
      id: '90',
      rank: 1,
      symbol: 'BTC',
      name: 'Bitcoin',
      priceUsd: 80296.30,
      percentChange24h: 0.61,
      percentChange7d: 0.57,
      marketCapUsd: 1600000000000,
      volume24: 16500000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/bitcoin.png',
    ),
    CryptoEntity(
      id: '80',
      rank: 2,
      symbol: 'ETH',
      name: 'Ethereum',
      priceUsd: 2518.50,
      percentChange24h: 1.49,
      percentChange7d: 1.08,
      marketCapUsd: 307500000000,
      volume24: 8500000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/ethereum.png',
    ),
    CryptoEntity(
      id: '58',
      rank: 3,
      symbol: 'USDT',
      name: 'Tether',
      priceUsd: 1.00,
      percentChange24h: 0.25,
      percentChange7d: 0.19,
      marketCapUsd: 183600000000,
      volume24: 43400000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/tether.png',
    ),
    CryptoEntity(
      id: '2710',
      rank: 4,
      symbol: 'BNB',
      name: 'Binance Coin',
      priceUsd: 580.20,
      percentChange24h: 2.15,
      percentChange7d: 1.87,
      marketCapUsd: 85200000000,
      volume24: 1200000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/binance-coin.png',
    ),
    CryptoEntity(
      id: '2',
      rank: 5,
      symbol: 'XRP',
      name: 'XRP',
      priceUsd: 0.52,
      percentChange24h: -0.34,
      percentChange7d: -1.23,
      marketCapUsd: 28000000000,
      volume24: 980000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/xrp.png',
    ),
    CryptoEntity(
      id: '52',
      rank: 6,
      symbol: 'ADA',
      name: 'Cardano',
      priceUsd: 0.34,
      percentChange24h: 0.89,
      percentChange7d: 2.45,
      marketCapUsd: 12000000000,
      volume24: 340000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/cardano.png',
    ),
    CryptoEntity(
      id: '72',
      rank: 7,
      symbol: 'DOGE',
      name: 'Dogecoin',
      priceUsd: 0.12,
      percentChange24h: 3.21,
      percentChange7d: 5.67,
      marketCapUsd: 17000000000,
      volume24: 780000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/dogecoin.png',
    ),
    CryptoEntity(
      id: '83',
      rank: 8,
      symbol: 'SOL',
      name: 'Solana',
      priceUsd: 142.75,
      percentChange24h: -1.23,
      percentChange7d: -3.45,
      marketCapUsd: 62000000000,
      volume24: 2100000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/solana.png',
    ),
    CryptoEntity(
      id: '118',
      rank: 9,
      symbol: 'DOT',
      name: 'Polkadot',
      priceUsd: 6.78,
      percentChange24h: 1.87,
      percentChange7d: 2.34,
      marketCapUsd: 8900000000,
      volume24: 220000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/polkadot.png',
    ),
    CryptoEntity(
      id: '1027',
      rank: 10,
      symbol: 'MATIC',
      name: 'Polygon',
      priceUsd: 0.52,
      percentChange24h: -0.78,
      percentChange7d: 1.23,
      marketCapUsd: 4800000000,
      volume24: 180000000,
      logoUrl: 'https://c2.coinlore.com/img/25x25/polygon.png',
    ),
  ];

  // Datos para detalle de moneda
  static Map<String, dynamic> getCoinDetail(String id) {
    final coin = cryptos.firstWhere((c) => c.id == id);
    return {
      'id': coin.id,
      'symbol': coin.symbol,
      'name': coin.name,
      'logo': coin.logoUrl ?? '',
      'price': coin.priceUsd,
      'change24h': coin.percentChange24h,
      'change7d': coin.percentChange7d,
      'marketCap': coin.marketCapUsd,
      'volume24': coin.volume24,
      'circulatingSupply': coin.marketCapUsd / coin.priceUsd, // Simulado
      'maxSupply': coin.marketCapUsd / coin.priceUsd * 1.5, // Simulado
      'ath': coin.priceUsd * 1.5,
      'athDate': '2024-03-14',
      'website': 'https://${coin.name.toLowerCase()}.org',
      'twitter': 'https://twitter.com/${coin.symbol.toLowerCase()}',
    };
  }

  // Buscar cryptos por nombre o símbolo
  static List<CryptoEntity> searchCryptos(String query) {
    if (query.isEmpty) return cryptos;

    final lowerQuery = query.toLowerCase();
    return cryptos
        .where(
          (crypto) =>
              crypto.name.toLowerCase().contains(lowerQuery) ||
              crypto.symbol.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
