import 'package:basket_of_fruit/model/basket_model.dart';
import 'package:basket_of_fruit/model/tray_model.dart';
import 'package:basket_of_fruit/presentation/home_screen/header_space.dart';
import 'package:basket_of_fruit/presentation/home_screen/list_of_baskets.dart';
import 'package:basket_of_fruit/presentation/home_screen/list_of_trays.dart';
import 'package:basket_of_fruit/state/basket_provider.dart';
import 'package:basket_of_fruit/state/tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the initial tray state from SharedPreferences
  List<TrayState> initialTrayState = await TrayStateNotifier.loadTrayState();
  List<BasketState> initialBasketState =
      await BasketStateNotifier.loadBasketState();

  // Initialize the TrayStateNotifier with the loaded state
  final initializedTrayStateNotifier = TrayStateNotifier(initialTrayState)..state = initialTrayState;
  final initializedBasketStateNotifier = BasketStateNotifier(initialBasketState)
    ..state = initialBasketState;

  runApp(ProviderScope(
      overrides: [
    trayStateProvider.overrideWithProvider(
      StateNotifierProvider<TrayStateNotifier, List<TrayState>>(
        (ref) => initializedTrayStateNotifier,
      ),
    ),
    basketsStateProvider.overrideWithProvider(
      StateNotifierProvider<BasketStateNotifier, List<BasketState>>(
            (ref) => initializedBasketStateNotifier,
      ),
    ),
  ],
      child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Basket of Fruits'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Column(
          children: [
            Column(
              children: [
                HeaderSpace(),
                ///List of Baskets
                ListOfBaskets(),
                ///Scrollable List of 6 Trays
                ListOfTrays(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




