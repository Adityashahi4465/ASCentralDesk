import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/mq.dart';
import '../../../../../../theme/pallet.dart';

class Banners extends StatefulWidget {
  const Banners({
    Key? key,
  }) : super(key: key);

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _length = 0;

  void _initTabController(int length) {
    _tabController = TabController(vsync: this, length: length);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MQuery.height * 0.2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('slider').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final banners = snapshot.data!.docs
                    .map((doc) {
                      final data = doc.data() as Map<String, dynamic>?;
                      return data != null ? BannerItem(data: data) : null;
                    })
                    .where((banner) => banner != null)
                    .map((banner) => banner!)
                    .toList();
                if (banners.length != _length) {
                  _tabController?.dispose(); // dispose the previous instance
                  _length = banners.length;
                  _initTabController(_length);
                }

                return _tabController == null
                    ? Container()
                    : TabBarView(
                        controller: _tabController!,
                        children: banners,
                      );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_length, (index) {
                  return _tabController == null
                      ? Container()
                      : PageIndicator(
                          index: index,
                          controller: _tabController!,
                        );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const BannerItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(data['imageUrl'] as String, fit: BoxFit.cover);
  }
}

class PageIndicator extends StatefulWidget {
  final int index;
  final TabController controller;

  const PageIndicator({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.index == widget.controller.index;

    // add listener to tabcontroller to update page indicator size
    widget.controller.addListener(() {
      setState(() {
        _expanded = widget.index == widget.controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _expanded ? 15 : 5,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _expanded ? Pallete.kPrimaryColor : Colors.grey,
      ),
    );
  }
}
