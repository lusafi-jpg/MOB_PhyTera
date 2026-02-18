
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/promo_banner.dart';
import '../widgets/action_grid.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const PromoBanner(),
            const SizedBox(height: 24),
            const ActionGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
