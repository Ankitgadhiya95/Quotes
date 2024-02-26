import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:untitled/Api_Repository/quote_api.dart';
import 'package:untitled/DataBase_repository/quote_database_repository.dart';
import 'package:untitled/Screen/quote_like_screen.dart';
import 'package:untitled/Model/quote_model.dart';
import 'detile_screen.dart';
import '../Controler/getx_quote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    QuoteAPI().loadPostData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  GetxCon controller = Get.put(GetxCon());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Likecreen()));
              },
              icon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  // color:_darkTheme.
                  ),
              child: Text(
                'Quote',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Obx(
              () => Row(
                children: [
                  Switch(
                    value: controller.isDark,
                    onChanged: (val) {
                      controller.isDark = val;
                      Get.changeThemeMode(
                        controller.isDark ? ThemeMode.dark : ThemeMode.light,
                      );
                      //_saveThemeStatus();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Theme",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  //  selectedPage = 'Settings';
                });
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                List<QuoteModel> list = [];

                await DataBaseRepo.getItems(
                        DataBaseRepo().list[index].toString())
                    .then((value) {
                  setState(() {
                    list = value;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeteilScreen(
                      list: list,
                      name: DataBaseRepo().list[index].toString(),
                    ),
                  ));
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: screenWidth - 220,
                decoration: BoxDecoration(
                    color: DataBaseRepo().colorList[index],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DataBaseRepo().list[index].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: AssetImage("Assets/emoji/busy.png"),
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
