import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationBarCustom extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;
  final List<IconData> activeIcons;
  final Color colorIcons;
  final Color backgroundColor;
  final Color color;

  const NavigationBarCustom({super.key,required this.currentIndex, required
  this.onTap, required this.icons, required this.activeIcons,this.backgroundColor = Colors.transparent,
    this.color = Colors.blueAccent,this.colorIcons = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 65,
      backgroundColor: backgroundColor,
      color: color,
      onTap: (index) {
        onTap(index);
      },
      items: List.generate(icons.length,
          (index)=>Icon(
            currentIndex == index ? activeIcons[index] : icons[index],
            size: 20,
            color: colorIcons,
          )
      )
    );
  }
}

