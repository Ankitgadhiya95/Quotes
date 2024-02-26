import 'dart:core';

class QuoteModel {
  final int? quoteId;
  final String? quote;
  final int? isFav;
  final String? img;

  QuoteModel(
      {required this.quoteId,
      required this.quote,
      required this.isFav,
      required this.img});

  factory QuoteModel.fromJson(Map<String, dynamic> map) {
    return QuoteModel(
      quoteId: map['id'],
      quote: map['quote'],
      isFav: map['isFav'],
      img: map['img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'quote': quote, 'id': quoteId, 'isFav': isFav, 'img': img};
  }
}
