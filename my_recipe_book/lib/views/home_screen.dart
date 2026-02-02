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
                    if (viewModel.isLoading)
                      const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                      )
                    else if (viewModel.errorLoading)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Error ${viewModel.error}: ${viewModel.errorMessage}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
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
                            final recipe = viewModel.recipes[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/recipeDetail',
                                  arguments: recipe,
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE6E6FA),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: Image(
                                          image: AssetImage(recipe.imagePath),
                                          height: 95,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 36,
                                            child: SubmenuButton(
                                              menuChildren: [
                                                MenuItemButton(
                                                  onPressed: () {
                                                    viewModel.deleteRecipe(recipe.id);
                                                  },
                                                  leadingIcon: const Icon(
                                                      Icons.delete, size: 20),
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
                                                      Icons.edit, size: 20),
                                                  child: const Text('Edit'),
                                                ),
                                              ],
                                              child: Icon(
                                                Icons.menu,
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Flexible(
                                            child: Text(
                                              recipe.title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/recipeDetail',
                                                arguments: recipe,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
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
          if (viewModel.errorDeleting) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error while deleting'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
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