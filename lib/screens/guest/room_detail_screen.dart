import '../../core/app_colors.dart';
import '../../models/room_model.dart';
import '../../widgets/premium_widgets.dart';
import 'booking_screen.dart';

class RoomDetailScreen extends StatelessWidget {
  final RoomModel room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background/Hero Image
          Hero(
            tag: 'room-${room.id}',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(room.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          room.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryNeon.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            room.status,
                            style: const TextStyle(color: AppColors.primaryNeon),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.secondaryGold, size: 20),
                        const SizedBox(width: 5),
                        const Text('4.9 (120 reviews)', style: TextStyle(color: Colors.white54)),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Amenities',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _AmenityIcon(icon: Icons.wifi, label: 'Free Wifi'),
                        _AmenityIcon(icon: Icons.ac_unit, label: 'AC'),
                        _AmenityIcon(icon: Icons.pool, label: 'Pool'),
                        _AmenityIcon(icon: Icons.tv, label: 'Smart TV'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'About this room',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      room.description,
                      style: const TextStyle(color: Colors.white54, height: 1.5),
                    ),
                    const SizedBox(height: 100), // Space for CTA
                  ],
                ),
              ),
            ),
          ),

          // Sticky CTA Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.background.withOpacity(0.9)],
                ),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Price', style: TextStyle(color: Colors.white54)),
                      Text(
                        '\$${room.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNeon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingScreen(room: room)),
                        );
                      },
                      child: const Text('BOOK NOW', style: TextStyle(letterSpacing: 2)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white38, size: 28),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white24, fontSize: 10)),
      ],
    );
  }
}
