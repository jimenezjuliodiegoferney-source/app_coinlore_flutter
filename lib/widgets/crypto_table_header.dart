import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/responsive.dart';
import '../providers/settings_provider.dart';

class CryptoTableHeader extends ConsumerWidget {
  const CryptoTableHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
      ),
      child: Row(
        children: [
          // Rank - Siempre visible
          SizedBox(width: 32, child: _buildHeaderText('#', isDark)),

          // Coin - Siempre visible (flex 3 en móvil, 3 en otros)
          Expanded(
            flex: isMobile ? 3 : 3,
            child: _buildHeaderText('Coin', isDark),
          ),

          // Price - Siempre visible
          Expanded(
            flex: isMobile ? 2 : 2,
            child: _buildHeaderText('Price', isDark, align: TextAlign.right),
          ),

          // 24h - Siempre visible
          Expanded(
            flex: isMobile ? 2 : 1,
            child: _buildHeaderText('24h', isDark, align: TextAlign.right),
          ),

          // 7d - Ocultar en móvil
          if (!isMobile)
            Expanded(
              flex: 1,
              child: _buildHeaderText('7d', isDark, align: TextAlign.right),
            ),

          // Market Cap - Solo tablet y desktop
          if (!isMobile)
            Expanded(
              flex: isTablet ? 2 : 2,
              child: _buildHeaderText(
                'Market Cap',
                isDark,
                align: TextAlign.right,
              ),
            ),

          // 24h Vol - Solo desktop
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 2,
              child: _buildHeaderText(
                '24h Vol',
                isDark,
                align: TextAlign.right,
              ),
            ),

          // Espacio para botón Buy
          SizedBox(width: isMobile ? 50 : 60),
        ],
      ),
    );
  }

  Widget _buildHeaderText(
    String text,
    bool isDark, {
    TextAlign align = TextAlign.left,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
    );
  }
}
