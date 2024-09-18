import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  final String imagePath;

  const ImageBuilder({super.key, required this.imagePath});

  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isSelected = false; // Track if the image is selected
final GlobalKey imageKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward(); // Start animation automatically

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly off the bottom
      end: Offset.zero, // End at its final position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected; // Toggle the selected state on tap
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _isSelected ? 1.2 :1.0, // Increase the size of the selected card
                  child: Platform.isIOS
                      ? Image.network(
                        key: imageKey,
                          widget.imagePath,
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.85,
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                        key: imageKey,
                          imageUrl: widget.imagePath,
                          width: MediaQuery.of(context).size.width * 0.70,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ParallelFlex extends FlowDelegate{
ParallelFlex({
  required this.scrollable,
  required this.listItemContext,
  required this.backgroundImageKey,
}) : super(repaint: scrollable.position);

final ScrollableState scrollable;
final BuildContext listItemContext;
final GlobalKey backgroundImageKey;

@override
BoxConstraints getConstraints(int i , BoxConstraints constraints) {
  return  BoxConstraints.tightFor(width: constraints.maxWidth);
}
@override
void paintChildren(FlowPaintingContext context) {
  final scrolableBox = scrollable.context.findRenderObject() as RenderBox;
  final listItemBox = listItemContext.findRenderObject() as RenderBox;
  final listItemOffset = listItemBox.localToGlobal(
    listItemBox.size.centerRight(Offset.zero),
  ancestor: scrolableBox,
  );
  final viewPortDimension =scrollable.position.viewportDimension;
  final scrollFraction = (listItemOffset.dy/viewPortDimension).clamp(0.0, 1.0);

  final verticalAlignment = Alignment(0, scrollFraction*2 - 1);
  final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
  final listItemSize = context.size;
final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);
context.paintChild(0, transform: Transform.translate(offset: Offset(0, childRect.top),).transform);

}
@override
bool shouldRepaint(ParallelFlex oldDelegate){
  return scrollable!= oldDelegate.scrollable || listItemContext != oldDelegate.listItemContext || backgroundImageKey != oldDelegate.backgroundImageKey;
}

}
