import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../models/room_model.dart';
import '../../widgets/premium_widgets.dart';

class BookingScreen extends StatefulWidget {
  final RoomModel room;

  const BookingScreen({super.key, required this.room});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTimeRange? _selectedDateRange;
  int _guestCount = 1;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryNeon,
              onPrimary: Colors.black,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDateRange = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RESERVE YOUR STAY')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PremiumCard(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.room.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                title: Text(widget.room.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text('\$${widget.room.price}/Night', style: const TextStyle(color: AppColors.primaryNeon)),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Select Dates', style: TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _selectDateRange(context),
              child: PremiumCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, color: AppColors.primaryNeon),
                        const SizedBox(width: 15),
                        Text(
                          _selectedDateRange == null
                              ? 'Choose check-in & out dates'
                              : '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const Icon(Icons.edit, color: Colors.white24, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Guests', style: TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 15),
            PremiumCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Guests', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppColors.primaryNeon),
                        onPressed: () => setState(() => _guestCount > 1 ? _guestCount-- : null),
                      ),
                      Text('$_guestCount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryNeon),
                        onPressed: () => setState(() => _guestCount++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text('Payment Summary', style: TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 15),
            _buildPriceRow('Stay Duration', _selectedDateRange == null ? '0 nights' : '${_selectedDateRange!.duration.inDays} nights'),
            _buildPriceRow('Room Price', '\$${widget.room.price}'),
            const Divider(color: Colors.white12, height: 30),
            _buildPriceRow('Total Amount', '\$${_calculateTotal()}', isTotal: true),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _selectedDateRange == null ? null : () => _showSuccessDialog(context),
                child: const Text('CONFIRM BOOKING', style: TextStyle(letterSpacing: 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.white54, fontSize: isTotal ? 18 : 16)),
          Text(value, style: TextStyle(color: isTotal ? AppColors.primaryNeon : Colors.white, fontSize: isTotal ? 22 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  double _calculateTotal() {
    if (_selectedDateRange == null) return 0;
    return widget.room.price * _selectedDateRange!.duration.inDays;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Success!', style: TextStyle(color: AppColors.primaryNeon)),
        content: const Text('Your booking has been confirmed. Get ready for a Starlux experience.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('DONE', style: TextStyle(color: AppColors.secondaryGold)),
          ),
        ],
      ),
    );
  }
}
