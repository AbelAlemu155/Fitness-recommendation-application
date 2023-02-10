import 'package:firsstapp/FitnessApp/screens/Progress/statScreen.dart';
import 'package:firsstapp/FitnessApp/screens/home.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/all_food.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/all_workout.dart';
import 'package:firsstapp/FitnessApp/screens/plans/plans_screen.dart';
import 'package:firsstapp/FitnessApp/screens/profile/profile_screen.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_screen.dart';
import 'package:firsstapp/font/custom__icon_icons.dart';
import 'package:firsstapp/font/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// This is the stateful widget that the main application instantiates.
class AllScreen extends StatefulWidget {
  static const routeName = '/allscreen';
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<AllScreen> {
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<String> titles = ['Plans', 'Blogs', 'Workout Library', 'Food Library'];
  static List<Widget> _widgetOptions = <Widget>[
    PlansScreen(),
    HomeScreen(),
    AllWorkoutScreen(),
    AllFoodScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.cyan),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )),
                        )
                      ],
                    )
                  ],
                )),
            Container(
              color: selected1 ? Colors.grey.withOpacity(0.6) : Colors.white,
              child: ListTile(
                onTap: () {
                  setState(() {
                    selected1 = true;
                    selected4 = false;
                    selected2 = false;
                    selected3 = false;
                  });
                  Navigator.pushNamed(context, StatScreen.routeName);
                },
                leading: FaIcon(
                  FontAwesomeIcons.chartBar,
                  color: Colors.cyan,
                ),
                title: Text('Progress'),
              ),
            ),
            Container(
              color: selected2 ? Colors.grey.withOpacity(0.6) : Colors.white,
              child: ListTile(
                onTap: () {
                  setState(() {
                    selected4 = false;
                    selected1 = false;
                    selected2 = true;
                    selected3 = false;
                  });
                  Navigator.pushNamed(context, TrainerScreen.routeName);
                },
                leading: Icon(
                  Icons.supervised_user_circle_sharp,
                  color: Colors.cyan,
                ),
                title: Text('Trainer'),
              ),
            ),
            Container(
              color: selected4 ? Colors.grey.withOpacity(0.6) : Colors.white,
              child: ListTile(
                onTap: () {
                  setState(() {
                    selected4 = true;
                    selected1 = false;
                    selected2 = false;
                    selected3 = false;
                  });
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                },
                leading: FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.cyan,
                ),
                title: Text('Profile'),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Card(
        elevation: 20,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Custom_Icon.blogger),
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Custom_Icon.fitness_center),
              label: 'Workouts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Custom_Icon.food),
              label: 'Foods',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyan,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
