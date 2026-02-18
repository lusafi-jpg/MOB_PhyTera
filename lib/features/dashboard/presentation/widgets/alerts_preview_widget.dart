import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AlertsPreviewWidget extends StatelessWidget {
  const AlertsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Alerts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(onPressed: (){}, child: const Text("View All"))
              ],
            ),
            const SizedBox(height: 10),
            _buildAlertItem(context, 'Critical: Soil pH Low', AppColors.error),
            const Divider(color: AppColors.surface),
            _buildAlertItem(context, 'Warning: Drone Battery 15%', AppColors.warning),
            const Divider(color: AppColors.surface),
            _buildAlertItem(context, 'Info: Irrigation scheduled', AppColors.info),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(BuildContext context, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}
