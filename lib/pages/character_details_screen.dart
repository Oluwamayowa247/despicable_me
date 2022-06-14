import 'package:after_layout/after_layout.dart';
import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/style/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final double _expandedBottomSheet = 0;
  final double _collapsedBottomSheet = -250;
  final double _completeCollapsedBottomSheet = -330;

  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen>
    with AfterLayoutMixin<CharacterDetailsScreen> {
  double _bottomSheetPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'background-${widget.character.name} ',
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: characters[0].colors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft))),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 33,
                        color: Colors.white,
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      characters[0].imagePath,
                      height: screenHeight * 0.45,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Text(
                    characters[0].name,
                    style: AppTheme.heading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 25),
                  child: Text(
                    characters[0].description,
                    style: AppTheme.subHeading,
                  ),
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
          AnimatedPositioned(
              bottom: _bottomSheetPosition,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _onTap(),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 80,
                        child: Text(
                          'Clips',
                          style:
                              AppTheme.subHeading.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipWidget(),
                    )
                  ],
                ),
              ),
              )
        ],
      ),
    );
  }

  Widget _clipWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            children: [
              roundedContainer(Colors.redAccent),
              const SizedBox(
                height: 20,
              ),
              roundedContainer(Colors.greenAccent)
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            children: [
              roundedContainer(Colors.orangeAccent),
              const SizedBox(
                height: 20,
              ),
              roundedContainer(Colors.purple),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            children: [
              roundedContainer(Colors.grey),
              const SizedBox(
                height: 20,
              ),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            children: [
              roundedContainer(Colors.lightGreenAccent),
              const SizedBox(
                height: 20,
              ),
              roundedContainer(Colors.pinkAccent),
            ],
          )
        ],
      ),
    );
  }



  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
    _onTap() {
    setState(() {
      _bottomSheetPosition = isCollapsed
          ? widget._expandedBottomSheet
          : widget._collapsedBottomSheet;

          isCollapsed = !isCollapsed;
    });

  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetPosition = widget._collapsedBottomSheet;
      });
    });
  }
}
