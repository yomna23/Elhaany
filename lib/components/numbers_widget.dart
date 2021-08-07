import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  final double rate ;

  const NumbersWidget({Key? key, required this.rate}) : super(key: key);

  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildDivider(),
          buildButton(context, '$rate', 'Ranking'),
          buildDivider(),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(color: Colors.black,),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.black),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),
            ),
          ],
        ),
      );
}
