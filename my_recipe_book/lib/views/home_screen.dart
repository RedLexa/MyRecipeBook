import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
                            child: Consumer<HomeViewModel>(
                              builder: (context, viewModel, _) {
                                return Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: SubmenuButton(
                                          menuChildren: [
                                            MenuItemButton(
                                              onPressed: () {
                                                viewModel.deleteRecipe(index);
                                              },
                                              leadingIcon: const Icon(Icons.delete),
                                              child: const Text('Delete'),
                                            ),
                                            MenuItemButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Coming soon!')),
                                                );
                                              },
                                              leadingIcon: const Icon(Icons.edit),
                                              child: const Text('Edit'),
                                            ),
                                          ],
                                          child: Icon(
                                            Icons.menu,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      //ElevatedButton(onPressed: null, child: Icon(Icons.menu, size: 24,)),
                                      Center(child: Text('${viewModel.recipes[index].title}')),
                                      IconButton
                                        (onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Coming soon!')),
                                        );
                                      },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 24,
                                          )
                                      )
                                    ]
                                );
                              },
                            ),
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
