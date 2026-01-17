import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                ),
              );
            }, icon: Icon(
          Icons.home,
          size: 24,
        )),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("MyRecipeBook"),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(
                    //builder: (context) => const ProfileScreen(),
                  //),
                //);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon!')),
                );
              }, icon: Icon(
            Icons.account_circle
          ))
        ]

      ),
      body: Center(
        child: Consumer<HomeViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                children: [
                  const Text('My recipes'),
                  Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: viewModel.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: Colors.amber[200],
                            child: Center(child: Text('${viewModel.recipes[index].title}')),
                          );
                          },
                    ),
                  ),
                ],
              );
            }
          )
      ),
      floatingActionButton: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            return FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon!')),
                );
              },
              //viewModel.addRecipe,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          }
      )
    );
  }
}
