import 'package:flutter/material.dart';

var items = [
  ['Pasta', 6],
  ['Brown', 3],
  ['Thai', 2],
  ['Soba', 4],
];

var stock = [
  ['Pasta', 0],
  ['Brown', 0],
  ['Thai', 0],
  ['Soba', 0],
];

var order = [
  ['Pasta', 0],
  ['Brown', 0],
  ['Thai', 0],
  ['Soba', 0],
];

int itemsLength = items.length;

class CreateButton extends StatelessWidget {
  final int index;
  final String number;
  CreateButton(this.number, this.index);

  @override
  Widget build(BuildContext context) {
    void buttonPressed() {
      print('button pressed');
      stock[index][1] = number;
      print(stock);
      int itemsVar = items[index][1];
      int stockVar = stock[index][1];
      order[index][1] = itemsVar - stockVar;
      print(order);
    }

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        height: 75,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.5),
            //side: BorderSide(color: Colors.white),
          ),
          color: const Color(0xFF212121),
          textColor: Colors.white,
          child: Text(number),
          onPressed: buttonPressed,
        ),
      ),
    );
  }
}

class CreateSection extends StatelessWidget {
  final int itemIndex;

  CreateSection(this.itemIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            items[itemIndex][0].toString(),
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Row(children: [
          CreateButton('1', itemIndex),
          CreateButton('2,', itemIndex),
          CreateButton('3', itemIndex),
          CreateButton('4', itemIndex),
        ]),
      ],
    );
  }
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(0.1),
                    child: Card(
                      child: CreateSection(index),
                      color: const Color(0xFF212121),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
