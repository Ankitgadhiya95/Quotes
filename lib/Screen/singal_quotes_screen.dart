import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_it/share_it.dart';
import 'package:untitled/DataBase_repository/quote_database_repository.dart';

class SingalQuotes extends StatefulWidget {
  const SingalQuotes(
      {super.key,
      required this.index,
      required this.quote,
      required this.name,
      required this.img,
      required this.id});

  final int index;
  final String quote;
  final String name;
  final img;
  final int id;

  @override
  State<SingalQuotes> createState() => _SingalQuotesState();
}

class _SingalQuotesState extends State<SingalQuotes> {
  bool isLiked = false;
  TextStyle? fontStyle;
  int fontIndex = 0;
  Color? fontColor;
  int textColorIndex = 0;
  int imgIndex = 0;
  String? imges;

  ScreenshotController screenShot = ScreenshotController();

  List<TextStyle> fonts = [
    GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
    GoogleFonts.aclonica(fontSize: 20, color: Colors.white),
    GoogleFonts.akshar(fontSize: 20, color: Colors.white),
    GoogleFonts.aldrich(fontSize: 20, color: Colors.white),
    GoogleFonts.ibmPlexMono(fontSize: 20, color: Colors.white),
  ];

  List<Color> colorList = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.pink,
    Colors.yellow,
    CupertinoColors.systemGreen,
    Colors.cyan
  ];

  List<String> img = [
    "https://cdn.pixabay.com/photo/2020/05/02/08/39/azalea-5120368_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_640.jpg",
    "https://addons-media.operacdn.com/media/CACHE/images/themes/95/78195/1.0-rev1/images/f1b54fe9-e138-44e6-929b-182bb1e82a68/8b7b9410c460548223847494208085d9.jpg",
    "https://wallpapercave.com/wp/wp12303203.jpg",
    "https://addons-media.operacdn.com/media/CACHE/images/themes/95/78195/1.0-rev1/images/f1b54fe9-e138-44e6-929b-182bb1e82a68/8b7b9410c460548223847494208085d9.jpg",
    "https://cdn.pixabay.com/photo/2016/01/08/11/57/butterflies-1127666_1280.jpg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    imges = img.first;
    fontStyle = fonts.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 452,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (imgIndex == img.length - 1) {
                    imgIndex = 0;
                  }
                  imgIndex++;
                  imges = img[imgIndex];
                });
              },
              child: Stack(
                children: [
                  Screenshot(
                    controller: screenShot,
                    child: Container(
                      height: 402,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(imges!), fit: BoxFit.cover)),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              widget.quote!,
                              style: fontStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontIndex == fonts.length - 1) {
                          fontIndex = 0;
                        }
                        fontIndex++;
                        fontStyle = fonts[fontIndex];
                      });
                    },
                    icon: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.text_fields,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        if (isLiked == true) {
                          await DataBaseRepo.createLikeItem(
                              widget.quote, 1, widget.img);
                        } else {
                          await DataBaseRepo.deleteItem(widget.id);
                        }
                      },
                      icon: isLiked == true
                          ? Icon(
                              CupertinoIcons.heart_fill,
                              size: 20,
                              color: Colors.red,
                            )
                          : Icon(
                              CupertinoIcons.heart,
                              size: 20,
                              //  color: Colors.black,
                            ),
                    ),
                    Text(
                      "Like",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        screenShot
                            .capture(delay: Duration(milliseconds: 10))
                            .then((value) {
                          _saved(value);
                        });
                      },
                      icon: Icon(
                        Icons.save_alt,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Save",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: widget.quote!));
                      },
                      icon: Icon(
                        Icons.copy_rounded,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Copy",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ShareIt.text(
                            content: widget.quote!,
                            androidSheetTitle: widget.name!);
                      },
                      icon: Icon(
                        Icons.share,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Share",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _saved(image) async {
    final result = await ImageGallerySaver.saveImage(image);
    Fluttertoast.showToast(msg: "Saved");
  }
}
