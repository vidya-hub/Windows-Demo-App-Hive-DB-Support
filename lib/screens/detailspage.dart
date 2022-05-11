import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive/hive.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationBody(
      index: 0,
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const Icon(
                FluentIcons.account_management,
                size: 50,
              ),
              const Text(
                "Stored User Details",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.blue.withOpacity(0.2),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.7,
                child: FutureBuilder<Box>(
                  future: Hive.openBox('persons'),
                  builder: (context, AsyncSnapshot<Box> snapshot) {
                    List? personModelList = snapshot.data?.values.toList();
                    int listLength = personModelList?.length ?? 0;
                    return listLength > 0
                        ? ListView.builder(
                            itemCount: personModelList?.length ?? 0,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Card(
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      personModelList?[index].email ?? "",
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No Data Found"),
                          );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 5,
                  ),
                  child: Text('LogOut'),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, "/");
                },
              ),
              const SizedBox(
                height: 10,
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
                  personBox.isOpen ? personBox.clear() : null;
                  setState(() {});
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
