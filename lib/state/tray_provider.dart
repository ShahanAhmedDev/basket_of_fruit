import 'dart:convert';

import 'package:basket_of_fruit/model/tray_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<TrayState> _trayList = [
  TrayState(bananas: 2,apples: 5, mangoes: 10),
  TrayState(bananas: 3,apples: 2, mangoes: 2),
  TrayState(bananas: 2,apples: 3, mangoes: 20),
  TrayState(bananas: 0,apples: 0, mangoes: 0),
  TrayState(bananas: 10,apples: 10, mangoes: 10),
  TrayState(bananas: 5,apples: 5, mangoes: 5),
];


class TrayStateNotifier extends StateNotifier<List<TrayState>> {
  ///Have initial state to load from sharedPreferences an old list
  TrayStateNotifier(List<TrayState>? initialState) : super(initialState?? _trayList);


  static Future<List<TrayState>> loadTrayState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> trayStateJson = prefs.getStringList('trayState') ?? [];
    if (trayStateJson.isEmpty) {
      print("This is the trayStateJson $trayStateJson");
      return _trayList; // Default state
    }
    print("This is the trayStateJson $trayStateJson");
    return trayStateJson.map((json) => TrayState.fromJson(jsonDecode(json))).toList();
  }

  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> trayStateJson = state.map((trayState) => jsonEncode(trayState.toJson())).toList().cast<String>();
    print("Saving state of trayStateJson as $trayStateJson");
    await prefs.setStringList('trayState', trayStateJson);
  }

  void addFruit(int trayIndex, String fruitType) {
    print('adding fruit $fruitType at tray index $trayIndex');
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == trayIndex)
          state[i].copyWith(fruitType: fruitType, add: true)
        else
          state[i]
    ];
    saveState();
  }

  void removeFruit(int trayIndex, String fruitType) {
    print('removing fruit $fruitType at tray index $trayIndex');
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == trayIndex)
          state[i].copyWith(fruitType: fruitType, add: false)
        else
          state[i]
    ];
    saveState();

  }

  void transferFruit(int sourceIndex, int targetIndex, String fruitType) {
    print(
        "inside the transferFruit method adding from index $sourceIndex to index $targetIndex fruit type $fruitType");

    ///if source and target tray are the same then I don't do anything and return
    if (sourceIndex == targetIndex) {
      return;
    }
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == sourceIndex)
          state[i].copyWith(fruitType: fruitType, add: false)
        else if (i == targetIndex)
          state[i].copyWith(fruitType: fruitType, add: true)
        else
          state[i]
    ];
    saveState();
  }
}

final trayStateProvider =
    StateNotifierProvider<TrayStateNotifier, List<TrayState>>(
  (ref) => TrayStateNotifier(_trayList),
);
