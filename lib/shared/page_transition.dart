import 'package:flutter/material.dart';

class AppPageRoute extends PageRouteBuilder {
  final Widget child;

  AppPageRoute({required this.child})
    : super(
        transitionDuration: const Duration(milliseconds: 500),

        reverseTransitionDuration: const Duration(milliseconds: 400),

        pageBuilder: (context, animation, secondaryAnimation) => child,

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween(begin: const Offset(.15, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );

          final fade = CurvedAnimation(
            parent: animation,

            curve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: fade,

            child: SlideTransition(position: slide, child: child),
          );
        },
      );
}
