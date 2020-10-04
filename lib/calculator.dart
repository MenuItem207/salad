import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import './info.dart';

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
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //side: BorderSide(color: Colors.white),
          ),
          color: const Color(0xFF1859BB), //(0xFF303236),
          textColor: Colors.white,
          child: Text(
            number,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: buttonPressed,
        ),
      ),
    );
  }
}

// change buttonNumber to change number of buttons
Widget createButtonList(int buttonNumber, itemIndex) {
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: buttonNumber,
      itemBuilder: (context, index) {
        String indexString = (index + 1).toString();
        return Padding(
          padding: const EdgeInsets.all(1),
          child: CreateButton(indexString, itemIndex),
        );
      });
}

class CreateSection extends StatelessWidget {
  final int itemIndex;

  CreateSection(this.itemIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Text(
            items[itemIndex][0].toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 4,
          child: createButtonList(9, itemIndex),
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
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 180,
                    width: 370,
                    child: Padding(
                      padding: const EdgeInsets.all(0.1),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: CreateSection(index),
                        color: const Color(0xFF1859BB), //212121),
                      ),
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
