import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

var items = [
  ['Pasta', 6, 'main'],
  ['Brown', 3, 'main'],
  ['Thai', 2, 'main'],
  ['Soba', 4, 'main'],
];

var stock = [
  ['Pasta', 0, 'main'],
  ['Brown', 0, 'main'],
  ['Thai', 0, 'main'],
  ['Soba', 0, 'main'],
];

var order = [
  ['Pasta', 0, 'main'],
  ['Brown', 0, 'main'],
  ['Thai', 0, 'main'],
  ['Soba', 0, 'main'],
];

String clipboardFormat() {
  var clipboardText = [
    'Please order as follows(Quantity of goods needed in the refrigerator)\n',
  ];

  for (int i = 0; i < order.length; i++) {
    String itemName = order[i][0].toString();
    String itemQuantity = order[i][1].toString();
    clipboardText.insert(i + 1, itemName + ' - ' + itemQuantity);
  } // Adds all items into List clipboardText

  String clipboardString = '';

  for (int i = 0; i < clipboardText.length; i++) {
    clipboardString += '\n' + clipboardText[i].toString();
  }
  return clipboardString;
}

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
      var itemsVar = items[index][1].toString();
      var stockVar = stock[index][1].toString();
      order[index][1] = int.parse(itemsVar) - int.parse(stockVar);
      print(order);
    }

    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        height: 75,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            //side: BorderSide(color: Colors.white),
          ),
          color: const Color(0xFF303236),
          textColor: Colors.white,
          child: Text(
            number,
            style: TextStyle(fontSize: 20),
          ),
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
        Expanded(
          flex: 4,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CreateButton('1', itemIndex),
            CreateButton('2', itemIndex),
            CreateButton('3', itemIndex),
            CreateButton('4', itemIndex),
          ]),
        ),
      ],
    );
  }
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color(0xFF212121),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: const Color(0xFF185ABB),
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood,
              ),
              title: Text('Calculator'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.content_copy),
        onPressed: () {
          ClipboardManager.copyToClipBoard(clipboardFormat());
          print('copied');
        },
        backgroundColor: const Color(0xFF185ABB),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: const Color(0xFF212121),
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
