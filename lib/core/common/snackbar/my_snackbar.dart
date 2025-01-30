// import 'package:flutter/material.dart';
//
// showMySnackBar({
//   required BuildContext context,
//   required String message,
//   Color? color,
// }) {
//   ScaffoldMessenger.of(
//     context,
//   ).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: color ?? Colors.green,
//       duration: const Duration(seconds: 1),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15), // Circular shape
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';

void showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
  bool showAtTop = false, // Add a parameter to decide position
}) {
  if (showAtTop) {
    // Show at the top using an overlay
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Adjust this value for exact positioning
        left: 16.0,
        right: 16.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color ?? Colors.green,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    // Insert the entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay after duration
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  } else {
    // Default bottom SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.green,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
