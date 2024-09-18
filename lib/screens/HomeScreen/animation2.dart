import 'package:flutter/material.dart';

class Animation2 extends StatefulWidget {
  final String image;
  final String tag;

  const Animation2({Key? key, required this.image, required this.tag}) : super(key: key);

  @override
  _Animation2State createState() => _Animation2State();
}

class _Animation2State extends State<Animation2> with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Trigger the fade-in animation when the screen is loaded
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: widget.tag, // Ensure the same tag is used here
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250), // Duration for the expansion animation
              height: 500, // Final height of the image
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
               boxShadow:[
               BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color with opacity
                    spreadRadius: 5, // How wide the shadow spreads
                    blurRadius: 10,  // The blur effect
                    offset: Offset(0, 5), // X and Y offset of the shadow
                  ),
                ],
              ),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            duration: Duration(milliseconds: 800), // Duration for the fade-in effect
            opacity: _visible ? 1.0 : 0.0, // Controls the visibility
            child: Text(
              widget.tag, // Display the tag as text
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
