import 'package:flutter/material.dart';
import 'package:untitled/Screen/singal_quotes_screen.dart';
import 'package:untitled/DataBase_repository/quote_database_repository.dart';
import 'package:untitled/Model/quote_model.dart';

class Likecreen extends StatefulWidget {
  const Likecreen({super.key});

  @override
  State<Likecreen> createState() => _LikecreenState();
}

class _LikecreenState extends State<Likecreen> {
  List<QuoteModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    await DataBaseRepo.getLikeItems().then((value) {
      setState(() {
        list = value;
      });
      print(list.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Like Screen"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return SingalQuotes(
            index: index,
            quote: list[index].quote!,
            name: "name",
            img: list[index].img!,
            id: list[index].quoteId!,
          );
        },
      ),
    );
  }
}
