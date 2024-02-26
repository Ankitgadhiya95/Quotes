import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:untitled/DataBase_repository/quote_database_repository.dart';
import 'package:untitled/Model/quote_model.dart';

List<QuoteModel> jsonList = [];

class QuoteAPI {
  Future loadPostData() async {
    final db = await DataBaseRepo().db();

    List<QuoteModel> list = [];
    list = await DataBaseRepo.getItems('Alone');
    if (list.isEmpty) {
      var data = await rootBundle.loadString("Assets/quote.json");
      // print(data);

      var response = jsonDecode(data);
      // print("abc $response");
      for (var r in response) {
        print(r);
        var data = r;
        for (var e in data['quote']) {
          await DataBaseRepo.createItem(
              e['quote'], 0, data['catName'], db, e['img']);
          // print(e);
        }
        // jsonList.add(ToDoModel.fromJson(r));
      }
      print("xyz $jsonList");
    }
    await DataBaseRepo.likeDB(db);
  }
}
