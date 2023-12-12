import 'package:basket_of_fruit/state/tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FruitTrayItem extends ConsumerStatefulWidget {
  final int index;
  final int banana;
  final int apples;
  final int mango;

  FruitTrayItem(
      {required this.index,
      required this.banana,
      required this.apples,
      required this.mango});

  @override
  ConsumerState<FruitTrayItem> createState() => _FruitTrayItemState();
}

class _FruitTrayItemState extends ConsumerState<FruitTrayItem> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        final sourceTrayIndex = data['trayIndex'] as int;
        final fruitType = data['fruit'] as String;
        print(
            "inside the onAccept with data as  ${sourceTrayIndex} ${fruitType}");
        // Use context.read to get the notifier and call methods to update state
        ///Transfer fruit from one source to the other
        ref
            .read(trayStateProvider.notifier)
            .transferFruit(sourceTrayIndex, widget.index, fruitType);
      },
      builder: (context, _, __) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // margin: EdgeInsets.all(1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Tray ${widget.index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Bananas: ${widget.banana}'),
                              SizedBox(height: 10,),
                              widget.banana == 0?
                                  Container(
                                    color: Colors.transparent,
                                    width: 80,
                                    height: 80,
                                  ):
                              Draggable<Map<String, dynamic>>(
                                data: {
                                  'trayIndex': widget.index,
                                  'fruit': 'banana'
                                },
                                feedback: Material(
                                  child: Container(
                                    color: Colors.white,
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/banana.jpg',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/banana.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Apples: ${widget.apples}'),
                              SizedBox(height: 10,),
                              widget.apples == 0?
                              Container(
                                color: Colors.transparent,
                                width: 80,
                                height: 80,
                              ):
                              Draggable<Map<String, dynamic>>(
                                data: {
                                  'trayIndex': widget.index,
                                  'fruit': 'apple'
                                },
                                feedback: Material(
                                  child: Container(
                                    color: Colors.white,
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/apple.jpg',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/apple.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Mangoes: ${widget.mango}'),
                              SizedBox(height: 10,),
                              widget.mango == 0 ?
                              Container(
                                color: Colors.transparent,
                                width: 80,
                                height: 80,
                              ):
                              Draggable<Map<String, dynamic>>(
                                data: {
                                  'trayIndex': widget.index,
                                  'fruit': 'mango'
                                },
                                feedback: Material(
                                  child: Container(
                                    color: Colors.white,
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/mango.jpg',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/mango.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
