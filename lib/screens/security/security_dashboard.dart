import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/data_provider.dart';
import '../../widgets/premium_widgets.dart';

class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({super.key});

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}

class _SecurityDashboardState extends State<SecurityDashboard> {
  bool _isSosActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SECURITY MONITOR', style: TextStyle(color: Colors.redAccent)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Monitoring Feed Simulation
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryNeon.withOpacity(0.5)),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam_off, color: Colors.white24, size: 50),
                    Text('LIVE FEED ENCRYPTED', style: TextStyle(color: Colors.white24, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // SOS Button
            GestureDetector(
              onLongPress: () {
                setState(() => _isSosActive = !_isSosActive);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: _isSosActive ? Colors.red : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red, width: 2),
                  boxShadow: _isSosActive ? [const BoxShadow(color: Colors.red, blurRadius: 20)] : [],
                ),
                child: Center(
                  child: Text(
                    _isSosActive ? 'SOS ACTIVE - ALERT SENT' : 'HOLD FOR SOS',
                    style: TextStyle(
                      color: _isSosActive ? Colors.white : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Alerts', style: TextStyle(fontSize: 18, color: AppColors.secondaryGold)),
            ),
            const SizedBox(height: 15),
            StreamBuilder<List<AlertStatus>>(
              stream: Provider.of<DataProvider>(context).alertStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final alerts = snapshot.data!;
                return Column(
                  children: alerts.map((alert) {
                    return _buildAlertItem(
                      alert.message,
                      alert.location,
                      'Just now',
                      alert.isCritical ? Icons.report_problem : Icons.info_outline,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(String title, String location, String time, IconData icon) {
    return PremiumCard(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(location, style: const TextStyle(color: Colors.white70)),
        trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.white38)),
      ),
    );
  }
}
