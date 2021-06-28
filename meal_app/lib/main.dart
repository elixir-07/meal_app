import 'package:flutter/material.dart';
import 'dummy_data.dart';
import './screen/filter_screen.dart';
import './screen/meal_detail.dart';
import './screen/category_meals_screen.dart';
import './screen/categories_screen.dart';
import './screen/tabs_screen.dart';
import './model/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if ((_filters['gluten']) && (!meal.isGlutenFree)) {
            return false;
          }
          if ((_filters['lactose']) && (!meal.isLactoseFree)) {
            return false;
          }
          if ((_filters['vegetarian']) && (!meal.isVegetarian)) {
            return false;
          }
          if ((_filters['vegan']) && (!meal.isVegan)) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meal App",
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      //   // if (settings.name == '/meal-deal') {
      //   //   return ...;
      //   // }
      //   // else if (settings.name == '/something-else') {
      //   //   return ...;
      //   // }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },

      //if some url or page doesn't exist it goes to unKnown route referenced page
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
