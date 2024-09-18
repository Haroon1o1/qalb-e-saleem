import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qalb/screens/HomeScreen/animation2.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _current = 0;

  final List<dynamic> _movies = [
    {
      'title': 'منقبت',
      'image': 'assets/images/shajra_hasbia.png',
    },
    {
      'title': 'الفراق',
      'image': 'assets/images/alfiraq-dark.png',
    },
    {
      'title': 'قطعہ',
      'image': 'assets/images/muqadma-dark.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 320.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.75,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _carouselController,
          items: _movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Animation2(
                          image: movie['image'],
                          tag: movie['title'], // Pass the title as tag
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Hero(
                            tag: movie['title'], // Unique tag for each image
                            child: Container(
                              height: 240,
                              margin: const EdgeInsets.only(top: 10),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                movie['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                        
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
