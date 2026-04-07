class RoomModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String status;

  RoomModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.status,
  });
}

// Mock data
final List<RoomModel> mockRooms = [
  RoomModel(
    id: '1',
    title: 'Royal Suite',
    description: 'A luxurious suite with panoramic ocean views.',
    price: 500.0,
    imageUrl: 'https://images.unsplash.com/photo-1578683062331-159497e201b1',
    status: 'Ready',
  ),
  RoomModel(
    id: '2',
    title: 'Techno Studio',
    description: 'Modern studio with smart room features.',
    price: 300.0,
    imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a',
    status: 'Cleaning',
  ),
];
