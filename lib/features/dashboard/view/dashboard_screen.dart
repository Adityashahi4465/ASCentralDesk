import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../theme/theme.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({super.key});
  final List<String> chipLabels = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28.0,
                        backgroundImage: AssetImage('assets/images/temp.jpg'),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your Name',
                            style: AppTextStyle.displayHeavy.copyWith(
                              color: AppColors.black,
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            'Subtitle/Description',
                            style: AppTextStyle.displayLight.copyWith(
                              color: AppColors.subTitleColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      iconSize: 28,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active,
                        color: AppColors.pinkAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              OverallDetailsCard(
                cardGradient: AppColors.roundedButtonGradient,
              ),
              OverallDetailsCard(
                cardGradient: AppColors.blueGradient,
              ),
              const SizedBox(
                height: 12,
              ),
              PostsOverviewHeader(
                heading: 'Latest Complaints',
                onPressed: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  aspectRatio: 2.0,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  // pageSnapping: true,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return LatestComplaintsCard(chipLabels: chipLabels);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 12,
              ),
              PostsOverviewHeader(
                heading: 'Latest Events',
                onPressed: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  if (index % 2 == 1 && (index - 1) % 4 == 0) {
                    return const SizedBox(height: 32.0);
                  }
                  return LatestEventsCard(
                    size: size,
                  );
                },
                itemCount: 5,
              ),
              PostsOverviewHeader(
                heading: 'New Notices',
                onPressed: () {},
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.radio_button_checked_rounded,
                              color: AppColors.red,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Critical',
                              style: AppTextStyle.displayBold.copyWith(
                                color: AppColors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '#Aijf90343',
                          style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 14,
                            color: AppColors.subTitleColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'This is the title',
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'This is the subtitle of above notice',
                      style: AppTextStyle.textRegular.copyWith(
                        fontSize: 14,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
