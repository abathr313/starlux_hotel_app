import '../../core/app_colors.dart';
import '../../models/room_model.dart';
import '../../widgets/premium_widgets.dart';
import '../../widgets/shimmer_loading.dart';
import 'room_detail_screen.dart';

class GuestDashboard extends StatefulWidget {
  const GuestDashboard({super.key});

  @override
  State<GuestDashboard> createState() => _GuestDashboardState();
}

class _GuestDashboardState extends State<GuestDashboard> {
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading for shimmer effect
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('STARLUX LUXURY', style: TextStyle(letterSpacing: 3)),
              background: Container(color: AppColors.background),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Exclusive Rooms',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.secondaryGold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350,
                  child: _isLoading 
                    ? const DashboardShimmer()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mockRooms.length,
                        itemBuilder: (context, index) {
                          final room = mockRooms[index];
                          // ... existing room card logic ...
                        },
                      ),
                ),
                          tag: 'room-${room.id}',
                          child: Container(
                            width: 280,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: NetworkImage(room.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(room.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                      Text('\$${room.price}/Night', style: const TextStyle(color: AppColors.primaryNeon)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Service On-Tap',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: const [
                    ServiceButton(icon: Icons.fastfood, label: 'Room Service'),
                    ServiceButton(icon: Icons.cleaning_services, label: 'Housekeeping'),
                    ServiceButton(icon: Icons.spa, label: 'Spa & Wellness'),
                    ServiceButton(icon: Icons.car_rental, label: 'Valet'),
                  ],
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PremiumBottomNav(
        index: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryNeon, size: 40),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
        ],
      ),
    );
  }
}
