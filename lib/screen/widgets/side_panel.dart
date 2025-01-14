import 'package:flutter/material.dart';

class SidePanelWidget extends StatelessWidget {
  final Animation<Offset> panelAnimation;
  final List<String> currentSideImages;

  const SidePanelWidget({
    super.key,
    required this.panelAnimation,
    required this.currentSideImages,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 100,
      child: SlideTransition(
        position: panelAnimation,
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: currentSideImages.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    width: 220,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
