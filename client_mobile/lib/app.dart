import 'package:client_mobile/helpers/api.dart';
import 'package:client_mobile/pages/tabs/History_page.dart';
import 'package:client_mobile/pages/tabs/course_page.dart';
import 'package:client_mobile/pages/tabs/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var scafoldKey = GlobalKey<ScaffoldState>();

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  // final GlobalKey<FormState> _homeKey =
  //     GlobalKey<FormState>(debugLabel: '_homeScreenkey');

  Future setId(String id) async {
    //
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', id);
  }

  bool isLoading = true;

  Api api = Api();

  @override
  void initState() {
    //
    api.getCurrentUser().then((res) {
      if (res.statusCode == 200) {
        print(res.data['id']);
        setId(res.data['id'].toString());
      }
    });
    super.initState();
  }

  int currentindex = 1;

  List screens = [
    const HistoryPage(),
    const CoursePage(),
    const ProfilePage(),
  ];

  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scafoldKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey.withOpacity(0.8),
        elevation: 0,
        iconSize: 35.0,
        currentIndex: currentindex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
              label: 'Historique', icon: Icon(Icons.history_outlined)),
          BottomNavigationBarItem(
            label: 'Course',
            icon: Icon(Icons.home_max),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: screens[currentindex],
    );
  }
}
