import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devices')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Scanning for devices...')),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.qr_code_scanner, color: AppColors.background),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDeviceSection(context, 'Sensors', [
            _DeviceItem(name: 'Soil Sensor A1', battery: 85, status: 'Online', type: Icons.sensors),
            _DeviceItem(name: 'Soil Sensor B2', battery: 45, status: 'Online', type: Icons.sensors),
            _DeviceItem(name: 'Humidity Sensor H1', battery: 12, status: 'Low Battery', type: Icons.water_drop, isWarning: true),
          ]),
          const SizedBox(height: 24),
          _buildDeviceSection(context, 'Drones', [
            _DeviceItem(name: 'Drone Alpha', battery: 100, status: 'Docked', type: Icons.airplanemode_active),
            _DeviceItem(name: 'Drone Beta', battery: 15, status: 'Returning', type: Icons.airplanemode_active, isWarning: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildDeviceSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _DeviceItem extends StatelessWidget {
  final String name;
  final int battery;
  final String status;
  final IconData type;
  final bool isWarning;

  const _DeviceItem({
    required this.name,
    required this.battery,
    required this.status,
    required this.type,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isWarning ? AppColors.warning : AppColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(type, color: isWarning ? AppColors.warning : AppColors.primary),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(status, style: TextStyle(color: isWarning ? AppColors.warning : AppColors.textSecondary)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.battery_std, size: 16, color: _getBatteryColor(battery)),
            const SizedBox(width: 4),
            Text('$battery%', style: TextStyle(color: _getBatteryColor(battery), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Color _getBatteryColor(int level) {
    if (level > 50) return AppColors.success;
    if (level > 20) return AppColors.warning;
    return AppColors.error;
  }
}
