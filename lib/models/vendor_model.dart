class Vendor {
  final int? id;
  final String name;
  final String category;
  final double price;
  final String contact;

  Vendor({this.id, required this.name, required this.category, required this.price, required this.contact});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'contact': contact,
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: (map['price'] as num).toDouble(),
      contact: map['contact'],
    );
  }
}