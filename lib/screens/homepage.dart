import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final flyoutController = FlyoutController();
  String _getFlyoutMessge = "Please Enter Email and Password";

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: _buildNavigationBody(context),
    );
  }

  Future<void> _logIn() async {
    Box personBox = await Hive.openBox('persons');
    List personModelList = personBox.values.toList();
    int personListIndex = personModelList.indexWhere(
      (element) {
        return element.email == _emailController.text &&
            element.passWord == _passwordController.text;
      },
    );
    if (personListIndex == -1) {
      _getFlyoutMessge = "Please Enter Correct Credentials";
    } else {
      _getFlyoutMessge = "Logged In Successfully";
      Navigator.pushNamed(context, '/detailsScreen');
    }
    await showFlyout();
    personBox.close();
  }

  NavigationBody _buildNavigationBody(BuildContext context) {
    return NavigationBody(
      index: 0,
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const Icon(
                FluentIcons.account_management,
                size: 50,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
              _buildBody(),
            ],
          ),
        )
      ],
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        children: [
          TextFormBox(
            controller: _emailController,
            header: 'Email',
            placeholder: 'Please Enter Your Email',
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormBox(
            controller: _passwordController,
            header: 'Password',
            placeholder: 'Please Enter Your Password',
            obscureText: true,
          ),
          Flyout(
            controller: flyoutController,
            position: FlyoutPosition.below,
            content: (BuildContext context) {
              return _buildFlyoutContent();
            },
            child: FilledButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                child: Text('Login'),
              ),
              onPressed: () async {
                if (_emailController.text.isEmpty &&
                    _passwordController.text.isEmpty) {
                  await showFlyout();
                  return;
                } else {
                  await _logIn();
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account ?'),
              const SizedBox(
                width: 10,
              ),
              FilledButton(
                child: const Text('Register'),
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed("/register");
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFlyoutContent() {
    return Card(
      backgroundColor: const Color.fromARGB(191, 0, 140, 255),
      child: Text(
        _getFlyoutMessge,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showFlyout() async {
    flyoutController.open();
    await Future.delayed(const Duration(
      seconds: 1,
    )).then((_) {
      flyoutController.close();
    });
  }
}
