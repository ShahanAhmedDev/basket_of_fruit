import 'package:basket_of_fruit/state/basket_provider.dart';
import 'package:basket_of_fruit/state/tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketWidget extends ConsumerStatefulWidget {
  Color color;
  int number;
  int fruits;
  BasketWidget({required this.color, required this.number, required this.fruits});
  @override
  ConsumerState<BasketWidget> createState() => _BasketWidgetState();
}

class _BasketWidgetState extends ConsumerState<BasketWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(

        builder: (context, ref, _) {
          final basketsState = ref.watch(basketsStateProvider);
          final basketState = basketsState[widget.number -1];
          return DragTarget<Map<String, dynamic>>(
            onWillAccept: (data) => true,
            onAccept: (data) {
              print(
                  "inside the onAccept with data as  ${data}");
              final sourceTrayIndex = data['trayIndex'] as int;
              final fruitType = data['fruit'] as String;
              print("inside the onAccept with data as  ${sourceTrayIndex} ${fruitType}");
              print("deleting this from the sourceTray now  ${sourceTrayIndex} ${fruitType}");
              ///Delete from source Tray
              ref
                  .read(trayStateProvider.notifier).removeFruit(sourceTrayIndex, fruitType);
              ///Transfer fruit from one source to the other
              ref
                  .read(basketsStateProvider.notifier)
                  .addFruit(widget.number -1 );
            },
            builder: (context, _, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.purple.shade600,
                    //   offset: Offset(1, 1),
                    //   blurRadius: 10,
                    // ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Basket No: ${widget.number}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.shopping_basket,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Fruits: ${basketState.fruits}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Add more elements here as needed
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}