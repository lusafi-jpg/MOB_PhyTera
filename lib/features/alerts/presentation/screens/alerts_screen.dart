import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // Dummy Data
  final List<Map<String, dynamic>> _allAlerts = [
    {'id': '1', 'title': 'Soil pH Low', 'desc': 'Field A pH is 5.5, recommend liming.', 'priority': 'Critical'},
    {'id': '2', 'title': 'Drone Battery Low', 'desc': 'Drone #4 battery at 15%. Return for charging.', 'priority': 'Warning'},
    {'id': '3', 'title': 'Irrigation Scheduled', 'desc': 'Automated irrigation for Field B starts at 18:00.', 'priority': 'Info'},
    {'id': '4', 'title': 'Connection Lost', 'desc': 'Sensor Svc-02 lost connection 5 mins ago.', 'priority': 'Critical'},
    {'id': '5', 'title': 'Yield Forecast Updated', 'desc': 'AI has updated yield prediction for Field C.', 'priority': 'Info'},
  ];

  String _selectedFilter = 'All';

  List<Map<String, dynamic>> get _filteredAlerts {
    if (_selectedFilter == 'All') return _allAlerts;
    return _allAlerts.where((alert) => alert['priority'] == _selectedFilter).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical': return AppColors.error;
      case 'Warning': return AppColors.warning;
      case 'Info': return AppColors.info;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Center')),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: ['All', 'Critical', 'Warning', 'Info'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Alerts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAlerts.length,
              itemBuilder: (context, index) {
                final alert = _filteredAlerts[index];
                return Dismissible(
                  key: Key(alert['id']),
                  background: Container(
                    color: AppColors.success,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: AppColors.card,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.archive, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                     setState(() {
                        _allAlerts.removeWhere((item) => item['id'] == alert['id']);
                     });
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('${alert['title']} dismissed')),
                     );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getPriorityColor(alert['priority']).withValues(alpha: 0.1),
                        child: Icon(Icons.notifications, color: _getPriorityColor(alert['priority'])),
                      ),
                      title: Text(
                        alert['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          alert['desc'],
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                      onTap: () {
                         // Show details
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
