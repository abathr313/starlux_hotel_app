import '../../core/app_colors.dart';
import '../../core/audio_helper.dart';
import '../../providers/locale_provider.dart';
import '../../providers/data_provider.dart';
import '../../widgets/premium_widgets.dart';
import 'qr_scanner_screen.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocaleProvider>(context).locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('STAFF HUB'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: AppColors.primaryNeon),
            onPressed: () {
              AudioHelper.speak("New maintenance task in room 302", lang);
            },
          ),
        ],
      ],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PremiumCard(
              child: ListTile(
                leading: CircleAvatar(backgroundColor: AppColors.primaryNeon, child: Icon(Icons.person, color: Colors.black)),
                title: Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text('Maintenance Team', style: TextStyle(color: Colors.white70)),
                trailing: Chip(label: Text('On Duty'), backgroundColor: Colors.green),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Operational Status', style: TextStyle(fontSize: 18, color: AppColors.secondaryGold)),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<List<TaskStatus>>(
                stream: Provider.of<DataProvider>(context).taskStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      Color statusColor = task.status == 'Urgent' ? Colors.red : (task.status == 'Pending' ? Colors.orange : Colors.green);
                      return _buildRoomTask(task.title, task.status, Icons.task_alt, statusColor);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryNeon,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QrScannerScreen()),
          );
        },
        label: const Text('Scan QR', style: TextStyle(color: Colors.black)),
        icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
      ),
    );
  }

  Widget _buildRoomTask(String title, String subtitle, IconData icon, Color statusColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Icon(icon, color: statusColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      ),
    );
  }
}
