import 'package:flutter/material.dart';
import 'package:getfit/common/extensions/context_extensions.dart';

class ImageCarouselModal extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final Function(String) onImageSelected;

  const ImageCarouselModal({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.onImageSelected,
  });

  @override
  ImageCarouselModalState createState() => ImageCarouselModalState();
}

class ImageCarouselModalState extends State<ImageCarouselModal> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex =
        widget.initialIndex >= 0 && widget.initialIndex < widget.images.length
            ? widget.initialIndex
            : 0;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // Almost fullscreen
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Header with Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Background',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Image Carousel
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onImageSelected(widget.images[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(widget.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.images.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          // Select Button
          FilledButton(
            onPressed: () {
              widget.onImageSelected(widget.images[currentIndex]);
              context.pop();
            },
            style: FilledButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}
