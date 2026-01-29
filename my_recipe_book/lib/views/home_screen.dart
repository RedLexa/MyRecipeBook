import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import 'login_screen.dart';

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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
        ]

      ),
      body: Center(
          child: Consumer<HomeViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: viewModel.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFE6E6FA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Consumer<HomeViewModel>(
                              builder: (context, viewModel, _) {
                                return Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                              viewModel.recipes[index].imagePath),
                                          height: 130,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: SubmenuButton(
                                              menuChildren: [
                                                MenuItemButton(
                                                  onPressed: () {
                                                    viewModel.deleteRecipe(
                                                        index);
                                                  },
                                                  leadingIcon: const Icon(
                                                      Icons.delete),
                                                  child: const Text('Delete'),
                                                ),
                                                MenuItemButton(
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Coming soon!')),
                                                    );
                                                  },
                                                  leadingIcon: const Icon(
                                                      Icons.edit),
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
                                          Center(child: Text(
                                              '${viewModel.recipes[index]
                                                  .title}')),
                                          IconButton
                                            (onPressed: () {
                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                              const SnackBar(content: Text(
                                                  'Coming soon!')),
                                            );
                                          },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 24,
                                              )
                                          )
                                        ],
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
          return Transform.translate(
            offset: const Offset(0, -30),
            child: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon!')),
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}