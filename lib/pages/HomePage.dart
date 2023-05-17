import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/color_config.dart';
import '../provider/base_provider.dart';
import '../widgets/AddPasswordWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BaseProvider>().getAppDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BaseProvider>(
        builder: (context, provider, _) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  setColor('#214ED3'),
                  setColor('4169E1'),
                  setColor('#6988E7'),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 10,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(
                        Icons.menu,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    itemCount: provider.appDetails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.app_blocking_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    provider.appDetails[index].appName ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      provider.deleteCredential(
                                          provider.appDetails[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_note_sharp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline_sharp,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    provider.appDetails[index].userName ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.key,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (provider.appDetails[index].password ?? ''),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const AddPasswordWidget(),
      drawer: Drawer(
        width: 200,
        child: Column(
          children: const [
            CircleAvatar(),
            Text('Welcome'),
          ],
        ),
      ),
    );
  }
}
