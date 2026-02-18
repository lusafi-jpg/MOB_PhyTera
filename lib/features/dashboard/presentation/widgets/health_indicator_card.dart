import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HealthIndicatorCard extends StatelessWidget {
  const HealthIndicatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Farm Health',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Optimal',
                    style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(
              value: 0.92,
              backgroundColor: AppColors.background,
              color: AppColors.success,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              '92% Condition',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
