import 'package:flutter/material.dart';

class DetailNutritionScreen extends StatefulWidget{
  const DetailNutritionScreen({super.key});

  @override
  State<DetailNutritionScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DetailNutritionScreen>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail page"),
      ),
    );
  }
}