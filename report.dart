import 'package:flutter/material.dart';

class ss extends StatefulWidget {
  var url;
  ss({
    required this.url,
  });
  @override
  State<ss> createState() => _ssState(url: url);
}

class _ssState extends State<ss> {
  var url;
  _ssState({
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: Colors.white,
          width: 300,
          height: 300,

          margin: EdgeInsets.only(
            top: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
