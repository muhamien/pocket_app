import 'package:flutter/material.dart';
import 'package:pocket_app/presentations/main/home.dart';
import 'package:pocket_app/presentations/nutrotions/detail_nutrition.dart';

class Routes{
  Routes._();

  static const String main = "/home";
  static const String detailNutrition = "/detail_nutrition";

  static final routes = <String, WidgetBuilder>{
    main: (BuildContext context) => const HomeScreen(),
    detailNutrition: (BuildContext context) => const DetailNutritionScreen(),
  };
}