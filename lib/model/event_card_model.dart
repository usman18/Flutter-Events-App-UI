import 'package:flutter/material.dart';

class EventCardModel {

  bool inFocus;
  Matrix4 matrix4;
  String imagePath;
  double opacity;


  EventCardModel({this.inFocus = false, this.matrix4, this.imagePath, this.opacity = 1});

}