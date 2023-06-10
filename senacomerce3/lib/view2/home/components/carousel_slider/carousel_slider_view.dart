import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senacomerce3/model/ad_banner.dart';
import 'package:senacomerce3/view/home/components/carousel_slider/banner_card.dart';

class CarouselSliderView2 extends StatefulWidget {
  final List<AdBanner> bannerList;
  const CarouselSliderView2({Key? key, required this.bannerList})
      : super(key: key);

  @override
  State<CarouselSliderView2> createState() => _CarouselSliderView2State();
}

class _CarouselSliderView2State extends State<CarouselSliderView2> {
  int _currentIndex = 0;
  late List<Widget> _bannerList;

  @override
  void initState() {
    _bannerList =
        widget.bannerList.map((e) =>
            BannerCard(imageUrl: e.image)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _bannerList,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.bannerList.map((e) {
            int index = widget.bannerList.indexOf(e);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10,
                  horizontal: 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4)
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}