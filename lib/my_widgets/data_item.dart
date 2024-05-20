import 'package:flutter/material.dart';
import '../screens/data_screen.dart';

class DataItem extends StatelessWidget {
  final String id;
  final String title;
  final String data;
  final String imageUrl;

  DataItem(this.data, this.imageUrl, this.id, this.title);

  void slectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (c) => DataScreen(id, title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => slectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(19),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Image.asset(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              data,
              style: TextStyle(fontSize: 45, color: Colors.white),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
