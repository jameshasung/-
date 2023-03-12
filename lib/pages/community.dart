import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/res/color.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/widgets/circle_gradient_icon.dart';
import 'package:task_management/widgets/task.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'dart:async'; // new
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final imageList = [
  Image.asset('assets/images/petbottle.jpeg', fit: BoxFit.cover),
  Image.asset('assets/images/shoping.jpeg', fit: BoxFit.cover),
  Image.asset('assets/images/wash.jpeg', fit: BoxFit.cover),
  Image.asset('assets/images/image2.png', fit: BoxFit.cover),
];

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),

        title: const Text("둘러보기"),

        // actions: [
        //   _buildMiddle(),
        // ],
      ),
      body: _buildMiddle(),
    );
  }
}

Widget _buildMiddle() {
  return CarouselSlider(
    options: CarouselOptions(height: 450.0, autoPlay: true),
    items: imageList.map((image) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: image,
            ),
          );
        },
      );
    }).toList(),
  );
}
