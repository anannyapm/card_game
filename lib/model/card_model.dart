class CardModel{
  final int id;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    this.isFlipped = false,
    this.isMatched = false,
  });
}