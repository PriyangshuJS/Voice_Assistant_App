import 'package:assistant/pallete.dart';
import 'package:flutter/material.dart';

import '../Widgets/featureBox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("June"),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 160,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.assistantCircleColor,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 157,
                    width: 162,
                    //margin: EdgeInsets.only(top: 1),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/virtualAssistant.png"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius:
                    BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              padding: const EdgeInsets.all(15),
              child: const Text(
                "How may i assist you ?",
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                    fontFamily: "Cera Pro"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                "Here are some Features - ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const FeatureBox(
              color: Pallete.firstSuggestionBoxColor,
              description:
                  ' A smarter way to stay organized and informed with ChatGPT',
              name: 'Chat GPT',
            ),
            const FeatureBox(
              color: Pallete.secondSuggestionBoxColor,
              description:
                  'Get inspired and stay creative with your personal assistant powered by Dall-E',
              name: 'Dall-E',
            ),
            const FeatureBox(
              color: Pallete.thirdSuggestionBoxColor,
              description:
                  'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
              name: 'Smart Voice Assistant',
            ),
            const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.mic),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
