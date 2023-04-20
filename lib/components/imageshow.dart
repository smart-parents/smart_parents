// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageScreen extends StatefulWidget {
  final String imageUrl;
  const FullScreenImageScreen({Key? key, required this.imageUrl})
      : super(key: key);
  @override
  _FullScreenImageScreenState createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  double _scale = 1;
  double _previousScale = 1;

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
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: PhotoView(
              imageProvider: NetworkImage(widget.imageUrl),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              initialScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// class UrlImageWidget extends StatefulWidget {
//   final String imageUrl;

//   const UrlImageWidget({super.key, required this.imageUrl});

//   @override
//   _UrlImageWidgetState createState() => _UrlImageWidgetState();
// }

// class _UrlImageWidgetState extends State<UrlImageWidget> {
//   Uint8List? _imageBytes;

//   Future<void> _fetchImageBytes() async {
//     try {
//       var response = await http.get(Uri.parse(widget.imageUrl));
//       setState(() {
//         _imageBytes = response.bodyBytes;
//       });
//     } catch (e) {
//       print('Failed to fetch image: $e');
//     }
//   }

//   // void _shareImage() async {
//   //   try {
//   //     final tempPath = await ImageGallerySaver.saveImage(_imageBytes!);
//   //     await Share.shareFiles([tempPath]);
//   //   } catch (e) {
//   //     print('Failed to share image: $e');
//   //   }
//   // }
//   void _shareImage(String imageUrl) async {
//     await Share.shareFiles([imageUrl],
//         text: 'Image from URL'); // Share the image using the share_plus plugin
//   }

//   Future<void> _printImage() async {
//     try {
//       final pdf = pw.Document();
//       pdf.addPage(pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Center(
//             child: pw.Image(pw.MemoryImage(_imageBytes!)),
//           );
//         },
//       ));

//       await Printing.layoutPdf(onLayout: (format) async => pdf.save());
//     } catch (e) {
//       print('Failed to print image: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchImageBytes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _imageBytes != null
//         ? Column(
//             children: [
//               Image.memory(_imageBytes!),
//               ElevatedButton(
//                 onPressed: () {
//                   _shareImage(widget.imageUrl);
//                 },
//                 child: const Text('Share Image'),
//               ),
//               ElevatedButton(
//                 onPressed: _printImage,
//                 child: const Text('Print Image'),
//               ),
//             ],
//           )
//         : const CircularProgressIndicator();
//   }
// }
