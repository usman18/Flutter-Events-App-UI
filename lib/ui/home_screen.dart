import 'package:events_app/model/event_card_model.dart';
import 'package:events_app/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EventCardModel> eventCards = [];

  @override
  void initState() {
    super.initState();
    populateCards();
  }

  void populateCards() {
    for (int i = 8; i >= 0; i--) {
      eventCards.add(EventCardModel(
          inFocus: i == 0 ? true : false, imagePath: "images/image${((i) % 3) + 1}.jpeg", opacity: 1, matrix4: Matrix4Transform().matrix4));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeaderText(),
            Spacer(),
            _buildCardsSection(),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: () {
          eventCards.clear();
          setState(() {
            populateCards();
          });
        },
      ),
    );
  }

  Widget _buildHeaderText() {
    return Visibility(
      visible: eventCards.length > 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "EVENTS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 4,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kRedButtonColor,
              ),
              padding: EdgeInsets.all(8),
              child: Text(
                eventCards?.length?.toString() ?? "",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardsSection() {
    return Visibility(
      visible: eventCards.length > 0,
      child: Stack(
        children: eventCards
            .map((e) => Align(
                  alignment: Alignment.center,
                  child: EventCard(
                    imagePath: e.imagePath,
                    inFocus: e.inFocus,
                    opacity: e.opacity,
                    matrix4: e.matrix4,
                    onGoingTapped: () {
                      goingTappedAnimation(e);

                      int index = eventCards.indexOf(e);

                      if (index != 0) {
                        inFocusAnimation(eventCards[index - 1]);
                      }

                      Future.delayed(Duration(milliseconds: 800)).then((value) {
                        setState(() {
                          eventCards.removeAt(index);
                        });
                      });
                    },
                    onNotGoingTapped: () {
                      notGoingTappedAnimation(e);

                      int index = eventCards.indexOf(e);

                      if (index != 0) {
                        inFocusAnimation(eventCards[index - 1]);
                      }

                      Future.delayed(Duration(milliseconds: 800)).then((value) {
                        setState(() {
                          eventCards.removeAt(index);
                        });
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  void goingTappedAnimation(EventCardModel eventCardModel) {
    setState(() {
      eventCardModel.matrix4 = Matrix4Transform()
          .rotateDegrees(
            75,
            origin: Offset(
                MediaQuery.of(context).size.width * 0.8, //width of the card
                MediaQuery.of(context).size.height * 0.5 //height of the card
                ),
          )
          .matrix4;

      eventCardModel.opacity = 0;
    });
  }

  void notGoingTappedAnimation(EventCardModel eventCardModel) {
    setState(() {
      eventCardModel.matrix4 = Matrix4Transform()
          .rotateDegrees(
            -75,
            origin: Offset(0, MediaQuery.of(context).size.height * 0.5 //height of the card
                ),
          )
          .matrix4;
      eventCardModel.opacity = 0;
    });
  }

  void inFocusAnimation(EventCardModel eventCardModel) {
    setState(() {
      eventCardModel.inFocus = true;
    });
  }
}
