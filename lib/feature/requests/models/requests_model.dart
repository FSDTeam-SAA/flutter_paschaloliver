class RequestItem {
  final String name;
  final double price;
  final String date;
  final String time;
  final String service;
  final String email;
  final String phone;
  final String location;
  final String? avatarUrl;

  // details extras
  final double rating;
  final int ratingCount;
  final String duration;
  final String distance;

  const RequestItem({
    required this.name,
    required this.price,
    required this.date,
    required this.time,
    required this.service,
    required this.email,
    required this.phone,
    required this.location,
    this.avatarUrl,
    this.rating = 4.8,
    this.ratingCount = 350,
    this.duration = "15 min",
    this.distance = "1.1 Km",
  });
}