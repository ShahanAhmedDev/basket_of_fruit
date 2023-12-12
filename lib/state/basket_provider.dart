import 'dart:convert';

import 'package:basket_of_fruit/model/basket_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BasketStateNotifier extends StateNotifier<List<BasketState>> {
  ///Have initial state to load from sharedPreferences an old list
  BasketStateNotifier(List<BasketState>? initialState) :  super( initialState?? List.generate(3, (_) => BasketState()));

  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> basketStateJson = state.map((basketState) => jsonEncode(basketState.toJson())).toList().cast<String>();
    await prefs.setStringList('basketState', basketStateJson);
  }

 static Future<List<BasketState>> loadBasketState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> basketStateJson = prefs.getStringList('basketState') ?? [];
    if (basketStateJson.isEmpty){
      return List.generate(3, (_) => BasketState());
    }
    return basketStateJson.map((json) => BasketState.fromJson(jsonDecode(json))).toList();
  }


  void addFruit(int basketIndex) {
    state = [
      for(var i = 0; i < state.length; i++)
        if(i == basketIndex)
          state[i].addFruit()
        else
          state[i]
    ];
    saveState();
  }
}
final basketsStateProvider = StateNotifierProvider<BasketStateNotifier, List<BasketState>>(
      (ref) => BasketStateNotifier(List.generate(3, (_) => BasketState())),
);
