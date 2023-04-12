// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// class ZoomableImageScreen extends StatelessWidget {
//   final String imageUrl;

//   const ZoomableImageScreen({super.key, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Zoomable Image'),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onDoubleTap: () {
//             // Open the image in full size when tapped
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (BuildContext context) => FullScreenImageScreen(
//                   imageUrl: imageUrl,
//                 ),
//               ),
//             );
//           },
//           child: Hero(
//             tag: imageUrl,
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//               width: 200, // Set the desired width for the thumbnail image
//               height: 200, // Set the desired height for the thumbnail image
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class FullScreenImageScreen extends StatefulWidget {
  final String imageUrl;

  const FullScreenImageScreen({super.key, required this.imageUrl});

  @override
  _FullScreenImageScreenState createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = _previousScale * details.scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          _previousScale = 1.0;
          setState(() {});
        },
        child: Hero(
          tag: widget.imageUrl,
          child: PhotoView(
            imageProvider: NetworkImage(widget.imageUrl),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            initialScale: _scale,
            backgroundDecoration: const BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
