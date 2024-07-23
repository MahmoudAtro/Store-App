class Order {
  int? id;
  String title;
  String description;

  double price;

  String image;

  Order({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "image": image,
    };
  }
}
