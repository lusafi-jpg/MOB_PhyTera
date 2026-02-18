import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ActionGrid extends StatelessWidget {
  const ActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.health_and_safety,
        'label': 'Santé',
        'color': Colors.greenAccent,
      },
      {
        'icon': Icons.trending_up,
        'label': 'Rendement',
        'color': Colors.orangeAccent,
      },
      {'icon': Icons.store, 'label': 'Marketplace', 'color': Colors.blueAccent},
      {'icon': Icons.wb_sunny, 'label': 'Météo', 'color': Colors.yellowAccent},
      {'icon': Icons.devices, 'label': 'Tech/IoT', 'color': Colors.cyanAccent},
      {
        'icon': Icons.notifications_active,
        'label': 'Alertes',
        'color': Colors.redAccent,
      },
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Finances',
        'color': Colors.purpleAccent,
      },
      {
        'icon': Icons.lightbulb,
        'label': 'Conseils',
        'color': Colors.indigoAccent,
      },
      {
        'icon': Icons.support_agent,
        'label': 'Tâches',
        'color': Colors.tealAccent,
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final item = actions[index];
        return _buildActionCard(
          context,
          icon: item['icon'],
          label: item['label'],
          color: item['color'],
        );
      },
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
