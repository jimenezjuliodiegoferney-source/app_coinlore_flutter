import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
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
    if (price >= 1) return '\$${price.toStringAsFixed(2)}';
    if (price >= 0.01) return '\$${price.toStringAsFixed(4)}';
    return '\$${price.toStringAsFixed(8)}';
  }

  String _formatCompact(double value) {
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(1)}T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(1)}B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(1)}M';
    return '\$${value.toStringAsFixed(0)}';
  }

  Color _getChangeColor(double change) {
    if (change > 0) return Colors.green;
    if (change < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final padding = Responsive.horizontalPadding(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            ),
          ),
        ),
        child: Row(
          children: [
            // Rank - Siempre visible
            SizedBox(
              width: 32,
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),

            // Coin (logo + nombre + símbolo)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    width: isMobile ? 24 : 28,
                    height: isMobile ? 24 : 28,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        crypto.symbol.substring(0, 1),
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 12,
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 13 : 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          crypto.symbol,
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 12,
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
              flex: isMobile ? 2 : 2,
              child: Text(
                _formatPrice(crypto.priceUsd),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
            ),

            // 24h
            Expanded(
              flex: isMobile ? 2 : 1,
              child: Text(
                '${crypto.percentChange24h > 0 ? '+' : ''}${crypto.percentChange24h.toStringAsFixed(2)}%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isMobile ? 13 : 14,
                  color: _getChangeColor(crypto.percentChange24h),
                ),
              ),
            ),

            // 7d - Ocultar en móvil
            if (!isMobile)
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

            // Market Cap - Solo tablet y desktop
            if (!isMobile)
              Expanded(
                flex: isTablet ? 2 : 2,
                child: Text(
                  _formatCompact(crypto.marketCapUsd),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),

            // 24h Vol - Solo desktop
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: Text(
                  _formatCompact(crypto.volume24),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),

            // Botón Buy
            SizedBox(
              width: isMobile ? 50 : 60,
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
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 8),
                  minimumSize: const Size(0, 32),
                ),
                child: Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 10 : 11,
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
