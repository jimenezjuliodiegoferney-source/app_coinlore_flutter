import 'crypto_entity.dart';

// Modelo de respuesta de /api/ticker/?id={ID}
class TickerDetailModel {
  final String id;
  final String symbol;
  final String name;
  final int rank;
  final String priceUsd;
  final String percentChange24h;
  final String percentChange1h;
  final String percentChange7d;
  final String marketCapUsd;
  final String volume24;
  final String csupply;
  final String tsupply;
  final String msupply;

  TickerDetailModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.rank,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange1h,
    required this.percentChange7d,
    required this.marketCapUsd,
    required this.volume24,
    required this.csupply,
    required this.tsupply,
    required this.msupply,
  });

  factory TickerDetailModel.fromJson(Map<String, dynamic> json) {
    return TickerDetailModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      rank: int.tryParse(json['rank']?.toString() ?? '0') ?? 0,
      priceUsd: json['price_usd'] ?? '0',
      percentChange24h: json['percent_change_24h'] ?? '0',
      percentChange1h: json['percent_change_1h'] ?? '0',
      percentChange7d: json['percent_change_7d'] ?? '0',
      marketCapUsd: json['market_cap_usd'] ?? '0',
      volume24: json['volume24']?.toString() ?? '0',
      csupply: json['csupply'] ?? '0',
      tsupply: json['tsupply'] ?? '0',
      msupply: json['msupply'] ?? '',
    );
  }

  // Convertir a CryptoEntity (para consistencia)
  CryptoEntity toEntity() {
    return CryptoEntity(
      id: id,
      rank: rank,
      symbol: symbol,
      name: name,
      priceUsd: double.tryParse(priceUsd) ?? 0,
      percentChange24h: double.tryParse(percentChange24h) ?? 0,
      percentChange7d: double.tryParse(percentChange7d) ?? 0,
      marketCapUsd: double.tryParse(marketCapUsd) ?? 0,
      volume24: double.tryParse(volume24) ?? 0,
    );
  }
}

// Modelo de respuesta de /api/coin/info/?id={ID}
class CoinInfoModel {
  final String id;
  final String symbol;
  final String name;
  final String website;
  final String twitter;
  final String explorer;
  final String logo;
  final double ath;
  final String athDate;
  final String startDate;
  final String platform;

  CoinInfoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.website,
    required this.twitter,
    required this.explorer,
    required this.logo,
    required this.ath,
    required this.athDate,
    required this.startDate,
    required this.platform,
  });

  factory CoinInfoModel.fromJson(Map<String, dynamic> json) {
    return CoinInfoModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      website: json['website'] ?? '',
      twitter: json['twitter'] ?? '',
      explorer: json['explorer'] ?? '',
      logo: json['logo'] ?? '',
      ath: double.tryParse(json['ath']?.toString() ?? '0') ?? 0,
      athDate: json['ath_date'] ?? '',
      startDate: json['startdate'] ?? '',
      platform: json['platform'] ?? '',
    );
  }
}

// Entidad combinada para la pantalla de detalle
class CryptoDetailEntity {
  final TickerDetailModel ticker;
  final CoinInfoModel? info;

  CryptoDetailEntity({required this.ticker, this.info});

  String get id => ticker.id;
  String get symbol => ticker.symbol;
  String get name => ticker.name;
  double get price => double.tryParse(ticker.priceUsd) ?? 0;
  double get change24h => double.tryParse(ticker.percentChange24h) ?? 0;
  double get change7d => double.tryParse(ticker.percentChange7d) ?? 0;
  double get marketCap => double.tryParse(ticker.marketCapUsd) ?? 0;
  double get volume => double.tryParse(ticker.volume24) ?? 0;
  String get circulatingSupply => ticker.csupply;
  String get totalSupply => ticker.tsupply;
  String get maxSupply => ticker.msupply;
  String get logo => info?.logo ?? '';
  double get ath => info?.ath ?? 0;
  String get athDate => info?.athDate ?? '';
  String get startDate => info?.startDate ?? '';
  String get website => info?.website ?? '';
  String get twitter => info?.twitter ?? '';
  String get explorer => info?.explorer ?? '';
  String get platform => info?.platform ?? '';
}
