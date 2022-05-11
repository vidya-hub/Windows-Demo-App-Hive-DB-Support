import 'package:desktopapp/models/personModel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final flyoutController = FlyoutController();
  String _getFlyoutMessge = "Please Enter Email and Password";
  Future<void> registerData() async {
    Box personBox = await Hive.openBox('persons');
    int length = await personBox.add(
      PersonModel(
        email: _emailController.text,
        passWord: _passwordController.text,
      ),
    );

    print('Number of persons: ${personBox.length}');
    _getFlyoutMessge =
        "Register Successful \nNumber of persons: ${personBox.length}";
    await showFlyout();
    personBox.close();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: _buildNavigationBody(context),
    );
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
                FluentIcons.add_friend,
                size: 50,
              ),
              const Text(
                "Register",
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
          const SizedBox(
            height: 30,
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
                child: Text('Register'),
              ),
              onPressed: () async {
                if (_emailController.text.isEmpty &&
                    _passwordController.text.isEmpty) {
                  _getFlyoutMessge = "Please Enter Email and Password";
                  await showFlyout();
                  return;
                } else {
                  await registerData();
                }
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FilledButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              child: Text('Login'),
            ),
            onPressed: () async {
              Navigator.pushNamed(context, "/");
            },
          ),
          const SizedBox(
            height: 30,
          ),
          FilledButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              child: Text('Clear Cache'),
            ),
            onPressed: () async {
              Box personBox = await Hive.openBox('persons');
              personBox.clear();
            },
          ),
        ],
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
}
