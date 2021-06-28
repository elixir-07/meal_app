import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../widget/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FavouritesScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            affordability: favouriteMeals[index].affordability,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
