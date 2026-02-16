class Contact {
  final String id;
  String name;
  String phone;
  String email;
  bool isFavorite;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isFavorite = false,
  });
}
