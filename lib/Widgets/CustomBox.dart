import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_care/constants.dart';

class CustomBox extends StatelessWidget {
  final String img;
  final String title;
  final Function press;
  const CustomBox({
    Key key,
    this.img,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(img),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
