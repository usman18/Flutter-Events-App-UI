import 'package:events_app/ui/widgets/round_corner_button.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';


typedef OnTap = void Function();




class EventCard extends StatelessWidget {
  final bool inFocus;
  final String imagePath;
  final Matrix4 matrix4;
  final double opacity;

  final OnTap onGoingTapped;
  final OnTap onNotGoingTapped;


  const EventCard({Key key, this.inFocus = false, this.imagePath, this.matrix4, this.onGoingTapped, this.onNotGoingTapped, this.opacity = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: opacity == 0,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: Duration(
          milliseconds: 500,
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          width: inFocus ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          curve: Curves.bounceOut,
          margin: EdgeInsets.only(
            left: inFocus ? 0 : 16,
            right: inFocus ? 0 : 16,
            top: inFocus ? 32 : 0,
            bottom: inFocus ? 0 : 32,
          ),
          transform: matrix4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)
                    )
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(""),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("30.05.2020",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width * 0.1,
                            color: kAccentColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("CAMPING IN NORWAY",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text("NORE UG UVDAL\n(MOUNTAINS)",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("ATTENDING",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("8/20",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: kCardColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: RoundCornerButton(
                            text: 'DON\'T',
                            buttonColor: kRedButtonColor,
                            onTap: onNotGoingTapped,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: RoundCornerButton(
                            text: 'I\'M IN',
                            buttonColor: kGreenButtonColor,
                            onTap: onGoingTapped,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
