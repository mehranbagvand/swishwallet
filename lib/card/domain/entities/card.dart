


class Card {
  final int? id;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String nameOnCard;

  const Card(
       {
         required this.cardNumber,
         required this.expiryDate,
         required this.cvv,
         required this.nameOnCard,
    this.id,
  });
}