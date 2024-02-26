import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screen/singal_quotes_screen.dart';
import 'package:untitled/Model/quote_model.dart';

class DeteilScreen extends StatefulWidget {
  DeteilScreen({super.key, required this.list, required this.name});

  final List<QuoteModel> list;
  final name;

  @override
  State<DeteilScreen> createState() => _DeteilScreenState();
}

class _DeteilScreenState extends State<DeteilScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
      ),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return SingalQuotes(
            index: index,
            quote: widget.list[index].quote!,
            name: widget.name,
            img: widget.list[index].img!, id: widget.list[index].quoteId!,
          );
        },
      ),
    );
  }
}
