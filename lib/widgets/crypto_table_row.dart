import 'package:flutter/material.dart';

import '../models/crypto_entity.dart';

class CryptoTableRow extends StatelessWidget {
  final int rank;
  final CryptoEntity crypto;
  final VoidCallback onTap;

  const CryptoTableRow({
    super.key,
    required this.rank,
    required this.crypto,
    required this.onTap,
  });

  String _formatPrice(double price) {
    if (price >= 1000) {
      return '\$${price.toStringAsFixed(2)}';
    } else if (price >= 1) {
      return '\$${price.toStringAsFixed(2)}';
    } else if (price >= 0.01) {
      return '\$${price.toStringAsFixed(4)}';
    } else {
      return '\$${price.toStringAsFixed(8)}';
    }
  }

  String _formatMarketCap(double value) {
    if (value >= 1e12) {
      return '\$${(value / 1e12).toStringAsFixed(1)}T';
    } else if (value >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(1)}B';
    } else if (value >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(1)}M';
    } else {
      return '\$${value.toStringAsFixed(0)}';
    }
  }

  Color _getChangeColor(double change) {
    if (change > 0) return Colors.green;
    if (change < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            ),
          ),
        ),
        child: Row(
          children: [
            // Rank
            SizedBox(
              width: 40,
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            // Coin (nombre + símbolo)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Logo mock (placeholder)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        crypto.symbol.substring(0, 1),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          crypto.symbol,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Expanded(
              flex: 2,
              child: Text(
                _formatPrice(crypto.priceUsd),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            // 24h
            Expanded(
              flex: 1,
              child: Text(
                '${crypto.percentChange24h > 0 ? '+' : ''}${crypto.percentChange24h.toStringAsFixed(2)}%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: _getChangeColor(crypto.percentChange24h),
                ),
              ),
            ),
            // 7d
            Expanded(
              flex: 1,
              child: Text(
                '${crypto.percentChange7d > 0 ? '+' : ''}${crypto.percentChange7d.toStringAsFixed(2)}%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: _getChangeColor(crypto.percentChange7d),
                ),
              ),
            ),
            // Market Cap
            Expanded(
              flex: 2,
              child: Text(
                _formatMarketCap(crypto.marketCapUsd),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            // 24h Volume
            Expanded(
              flex: 2,
              child: Text(
                _formatMarketCap(crypto.volume24),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            // Botón Buy (decorativo)
            SizedBox(
              width: 60,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Buy ${crypto.symbol}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: const Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
