import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: AppColors.background),
            ),
            const SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Farm Owner', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            _ProfileOption(icon: Icons.devices, title: 'My Devices', onTap: () => context.push('/devices')),
            _ProfileOption(icon: Icons.subscriptions, title: 'Subscription Plan', onTap: () {}),
            _ProfileOption(icon: Icons.notifications, title: 'Notifications', onTap: () {}),
            _ProfileOption(icon: Icons.security, title: 'Security', onTap: () {}),
            _ProfileOption(icon: Icons.language, title: 'Language', onTap: () {}),
            const SizedBox(height: 24),
            _ProfileOption(icon: Icons.logout, title: 'Logout', isDestructive: true, onTap: () => context.go('/login')),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileOption({required this.icon, required this.title, required this.onTap, this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
        title: Text(title, style: TextStyle(color: isDestructive ? AppColors.error : Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
