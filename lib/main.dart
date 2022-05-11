import 'package:desktopapp/models/personModel.dart';
import 'package:desktopapp/screens/detailspage.dart';
import 'package:desktopapp/screens/homepage.dart';
import 'package:desktopapp/screens/registerpage.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/detailsScreen': (context) => const DetailsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
