import 'package:flutter/material.dart';

import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/pages/character_details_screen.dart';
import 'package:despicable_me/style/styleguide.dart';

// ignore: must_be_immutable
class CharacterWidget extends StatelessWidget {
  final Character character;
  final PageController pageController;
  final int currentPage;

  const CharacterWidget({
    Key? key,
    required this.character,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, _, __) => CharacterDetailsScreen(
                      character: character,
                    )));
      }),
      // child: AnimatedBuilder(
      //   animation: pageController,
      //   builder: (BuildContext context, Widget? child) {

      //     return CharacterWidget(character: character, pageController: pageController, currentPage: currentPage);
      //    },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (BuildContext context, Widget? child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page! - currentPage;
            value = (1 - (value.abs() * 0.6)).clamp(0.0, 1.0);
          }

          return Stack(children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: Hero(
                  tag: 'background-${character.name}',
                  child: Container(
                    height: 0.65 * screenHeight,
                    width: 0.9 * screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: character.colors,
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                    ),
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 110.0),
              child: Hero(
                tag: "image-${character.name}",
                child: Image.asset(
                  character.imagePath,
                  height: screenHeight * 0.55 * value,
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    character.name,
                    style: AppTheme.heading,
                  ),
                  Text(
                    'Tap to Read More',
                    style: AppTheme.subHeading,
                  ),
                ],
              ),
            )
          ]);
        },
      ),
    );
  }
}

//Create a custom ClipRect
class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    //Start
    clippedPath.moveTo(8, size.height * 0.4);
    //Draw a straight line
    clippedPath.lineTo(size.width * -1.2, size.height - curveDistance);
    //Create a curve
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height * 1.2);
    //Continue the line after the curve
    clippedPath.lineTo(size.width - curveDistance, size.height);
    // Continue the curve
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    // continue straight line
    clippedPath.lineTo(size.width, 0 + curveDistance);

    // you should get the drift from here 😉

    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);

    return clippedPath;

    // TODO: implement getClip
    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    //   throw UnimplementedError();
    return true;
  }
}
