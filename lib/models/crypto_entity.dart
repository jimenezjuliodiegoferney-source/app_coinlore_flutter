class CryptoEntity {
  final String id;
  final int rank;
  final String symbol;
  final String name;
  final double priceUsd;
  final double percentChange24h;
  final double percentChange7d;
  final double marketCapUsd;
  final double volume24;
  final String? logoUrl; // Para detalle

  CryptoEntity({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.marketCapUsd,
    required this.volume24,
    this.logoUrl,
  });

  // Método para crear una copia con datos actualizados
  CryptoEntity copyWith({
    String? id,
    int? rank,
    String? symbol,
    String? name,
    double? priceUsd,
    double? percentChange24h,
    double? percentChange7d,
    double? marketCapUsd,
    double? volume24,
    String? logoUrl,
  }) {
    return CryptoEntity(
      id: id ?? this.id,
      rank: rank ?? this.rank,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      priceUsd: priceUsd ?? this.priceUsd,
      percentChange24h: percentChange24h ?? this.percentChange24h,
      percentChange7d: percentChange7d ?? this.percentChange7d,
      marketCapUsd: marketCapUsd ?? this.marketCapUsd,
      volume24: volume24 ?? this.volume24,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
