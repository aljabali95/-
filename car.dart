
class Car {
  int? id;
  String plate;
  String price;
  String payment;
  String image;
  String date;

  Car({
    this.id,
    required this.plate,
    required this.price,
    required this.payment,
    required this.image,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'price': price,
      'payment': payment,
      'image': image,
      'date': date,
    };
  }
}
