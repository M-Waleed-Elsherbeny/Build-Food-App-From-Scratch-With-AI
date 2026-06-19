import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/offer_model.dart';
import 'offer_banner.dart';

class HomeOffersListView extends StatelessWidget {
  final List<OfferModel> offers;

  const HomeOffersListView({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160.h,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          scrollDirection: Axis.horizontal,
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return OfferBanner(
              offer: offers[index],
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
