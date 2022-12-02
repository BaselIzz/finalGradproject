import 'package:flutter/material.dart';
import '../model/category.dart';
import '../values/values.dart';

class HomeScreen extends StatefulWidget {
  String? email;
  String? password;
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categorys = [
    Category("SoftDrinks",
        "https://th.bing.com/th/id/R.a779dfc4a5ba54b3f92f274bd265a833?rik=9%2br3rXteMLqMcA&pid=ImgRaw&r=0"),
    Category("Pizza",
        "https://heavy.com/wp-content/uploads/2020/12/GettyImages-133281966-e1608688624818.jpg?quality=65&strip=all"),
    Category("HotDrinks",
        "https://th.bing.com/th/id/OIP._VvmTz5uvGZ0J9drdmGtQAHaE5?pid=ImgDet&rs=1")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categorys.length,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            print(index);
            print(categorys[index]);
            print(widget.email);
            print(widget.password);
          },
          child: Container(
            width: 340,
            height: 250,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            categorys[index].Url,
                            width: MediaQuery.of(context).size.width,
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  categorys[index].Catagoryname,
                                  textAlign: TextAlign.left,
                                  style: Styles.customTitleTextStyle(
                                    color: AppColors.headingText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
