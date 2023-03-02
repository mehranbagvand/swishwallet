import '../../domain/entities/card.dart';

class CardModel extends Card {
  CardModel(
      {required super.id,
        required super.cardNumber,
        required super.expiryDate, required super.cvv, required super.nameOnCard,
      });



  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          (other is Card &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              cardNumber == other.cardNumber &&
              expiryDate == other.expiryDate &&
              cvv == other.cvv &&
              nameOnCard == other.nameOnCard);

  @override
  int get hashCode =>
      id.hashCode ^
      cardNumber.hashCode ^
      expiryDate.hashCode ^
      cvv.hashCode ^
      nameOnCard.hashCode;

  @override
  String toString() {
    return 'Card{ id: $id, card_number: $cardNumber, expiry_date: $expiryDate, '
        'cvv: $cvv, name_on_card: $nameOnCard}';
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card_number': cardNumber,
      'expiry_date': expiryDate,
      'cvv': cvv,
      'name_on_card': nameOnCard,
      // 'birth_date': birthDate.toIso8601String().split("T")[0],
    };
  }

  factory CardModel.fromMap(Map<String,dynamic> map) {
    return CardModel(
      id: map['id'] as int,
      nameOnCard: map['name_on_card'] as String,
      cvv: map['cvv'] as String,
      expiryDate: map['expiry_date'] as String,
      cardNumber: map['card_number'] as String
    );
  }

}

