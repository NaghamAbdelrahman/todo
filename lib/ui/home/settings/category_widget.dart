import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  String tittle;
  String userSelection;
  Function action;

  CategoryWidget(
      {required this.tittle,
      required this.userSelection,
      required this.action});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tittle,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: screenSize.height * 0.03),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userSelection,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              IconButton(
                  onPressed: () {
                    action();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                  ))
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
      ],
    );
  }
}
