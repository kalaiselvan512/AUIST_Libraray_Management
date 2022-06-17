import 'package:flutter/material.dart';
import 'package:istlibrary/screens/widgets/responsive.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Featured',
            style: TextStyle(
                fontSize: 36,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Color(0xFF077bd7)),
          ),
          // Expanded(
          //   child: Text(
          //     'Click your Domain',
          //     textAlign: TextAlign.end,
          //   ),
          // ),
        ],
      ),
    );
  }
}
