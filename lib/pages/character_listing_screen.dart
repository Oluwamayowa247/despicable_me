import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/style/styleguide.dart';
import 'package:despicable_me/widgets/character_widget.dart';
import 'package:flutter/material.dart';

class CharacterListingScreen extends StatefulWidget {
  const CharacterListingScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListingScreen> createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false,

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(text: "Despicable Me ", style: AppTheme.display1),
                    TextSpan(text: '\n'),
                    TextSpan(text: 'Characters', style: AppTheme.display2)
                  ]),
                ),
              ),

           Expanded(child: PageView(
             controller: _pageController,
             children: [
               for(var i = 0; i<characters.length; i++)
               CharacterWidget(character: characters[i], pageController: _pageController, currentPage: i)

               



              // CharacterWidget()
             ],
           ) )


            //  const Expanded(child: CharacterWidget())
            ],
          ),
        ),
      ),
    );
  }
}
