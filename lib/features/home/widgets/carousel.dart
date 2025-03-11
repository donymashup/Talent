import 'package:flutter/material.dart';
import 'package:talent_app/features/home/services/home_service.dart';
import 'package:talent_app/models/slider_images_model.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  List<Sliders> _sliderImages = [];
  final HomeService _homeService = HomeService();

  @override
  void initState() {
    super.initState();
    _fetchSliderImages();
  }

  Future<void> _fetchSliderImages() async {
    final sliderData = await _homeService.getSliderImages(context: context);
    if (sliderData != null && sliderData.sliders != null) {
      setState(() {
        _sliderImages = sliderData.sliders!.take(5).toList();
      });
      _startAutoScroll();
    }
  }

  void _startAutoScroll() async {
    while (mounted && _sliderImages.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      if (_controller.hasClients) {
        int nextPage = (_currentIndex + 1) % _sliderImages.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = nextPage;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double carouselHeight = screenWidth * 0.5; // Dynamic height based on width

    return Column(
      children: [
        SizedBox(
          width: double.infinity, // Ensures full width
          height: carouselHeight,
          child: _sliderImages.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : PageView.builder(
                  controller: _controller,
                  itemCount: _sliderImages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      child: Image.network(
                        _sliderImages[index].image!,
                        width: double.infinity,
                        height: carouselHeight,
                        fit: BoxFit.cover, // ✅ Ensures full coverage
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 100),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _sliderImages.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.jumpToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == entry.key ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
