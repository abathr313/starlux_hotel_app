import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_colors.dart';
import '../../widgets/premium_widgets.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADMIN COMMAND')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Operational Overview', style: TextStyle(fontSize: 18, color: AppColors.secondaryGold)),
            const SizedBox(height: 15),
            
            // Stats Chart
            PremiumCard(
              child: Column(
                children: [
                  const Text('Monthly Occupancy', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 3),
                              const FlSpot(2, 5),
                              const FlSpot(4, 4),
                              const FlSpot(6, 8),
                            ],
                            isCurved: true,
                            color: AppColors.primaryNeon,
                            barWidth: 4,
                            belowBarData: BarAreaData(show: true, color: AppColors.primaryNeon.withOpacity(0.1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: _buildSmallStat('Bookings', '124', Icons.calendar_today)),
                const SizedBox(width: 15),
                Expanded(child: _buildSmallStat('Revenue', '\$42K', Icons.attach_money)),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text('Staff Performance', style: TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 15),
            
            _buildStaffItem('Ahmed Ali', 'Manager', 98, AppColors.primaryNeon),
            _buildStaffItem('Sara Samer', 'Reception', 92, Colors.greenAccent),
            _buildStaffItem('Mark John', 'Security', 85, Colors.orangeAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStat(String label, String value, IconData icon) {
    return PremiumCard(
      child: Column(
        children: [
          Icon(icon, color: AppColors.secondaryGold),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildStaffItem(String name, String role, int score, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Text(name[0], style: TextStyle(color: color))),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(role, style: const TextStyle(fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
          Text('$score%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
