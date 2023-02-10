// Flutter code sample for SliverAppBar
//
// This sample shows a [SliverAppBar] and it's behavior when using the
// [pinned], [snap] and [floating] parameters.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodDetailScreen extends StatefulWidget {
  static const routeName = '/fooddetailscreen';
  Map<int, dynamic> args;
  FoodDetailScreen({required this.args});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetailScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    Map<int, dynamic> args2 = widget.args;
    print('djfffffffffffffs');

    final val = args2.values.elementAt(0);

    List<Widget> tiles = [
      ListTile(
        title: Text('1, ${val.ingredients}',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Mon",
            )),
      ),
      Divider(),
      ListTile(
        title: Text('2, ${val.ingredients}',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Mon",
            )),
      ),
      Divider(),
      ListTile(
        title: Text('3, ${val.ingredients}',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Mon",
            )),
      ),
      Divider(),
      ListTile(
        title: Text('4, ${val.ingredients}',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Mon",
            )),
      ),
      Divider(),
      ListTile(
        title: Text('5, ${val.ingredients}',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Mon",
            )),
      ),
      Divider(),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white.withOpacity(0)),
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 260.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(''),
              background: CachedNetworkImage(
                  height: 260,
                  width: 260,
                  fit: BoxFit.fitWidth,
                  imageUrl: val
                      .image_url), /*Image(
                image: AssetImage('Images/foods.jpg'),
                width: 260,
                height: 260,
                fit: BoxFit.fitWidth,
              ),*/
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(''),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text('${val.name}',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Mon",
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Calories',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Mon",
                                    )),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.cyan),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(40, 60))),
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text('${val.calories}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Mon",
                                      )),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Carbohydrates',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Mon",
                                    )),
                                Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.cyan),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(40, 60))),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text('${val.carb}',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "Mon",
                                        )))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Protein',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Mon",
                                    )),
                                Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.cyan),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(40, 60))),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text('${val.protein}',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "Mon",
                                        )))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Fat',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Mon",
                                    )),
                                Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.cyan),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(40, 60))),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text('${val.fat}',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "Mon",
                                        )))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 35),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.food_bank_rounded,
                                        size: 60,
                                        color: Colors.cyan,
                                      ),
                                      Text('Recipes',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Mon",
                                          )),
                                    ]),
                                  ])),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text('1, ${val.ingredients}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontFamily: "Mon",
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.cyan,
                            height: 7,
                            thickness: 2,
                            indent: 15,
                            endIndent: 20,
                          ),
                          ListTile(
                            title: Text('2, ${val.ingredients}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontFamily: "Mon",
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.cyan,
                            height: 7,
                            thickness: 2,
                            indent: 15,
                            endIndent: 20,
                          ),
                          ListTile(
                            title: Text('3, ${val.ingredients}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontFamily: "Mon",
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.cyan,
                            height: 7,
                            thickness: 2,
                            indent: 15,
                            endIndent: 20,
                          ),
                          ListTile(
                            title: Text('4, ${val.ingredients}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontFamily: "Mon",
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.cyan,
                            height: 7,
                            thickness: 2,
                            indent: 15,
                            endIndent: 20,
                          ),
                          ListTile(
                            title: Text('5, ${val.ingredients}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontFamily: "Mon",
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 35),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('How to make ${val.name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontFamily: "Mon",
                                        )),
                                    Row(children: [
                                      Icon(
                                        Icons.timelapse_rounded,
                                        size: 30,
                                        color: Colors.cyan,
                                      ),
                                      Text('${val.duration}')
                                    ])
                                  ])),
                          Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(top: 10),
                              child: Text('${val.description}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    fontFamily: "Mon",
                                  ))),
                          SizedBox(
                            height: 0,
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
