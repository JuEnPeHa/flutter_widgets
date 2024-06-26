import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ImplicitAnimationsPage extends StatelessWidget {
  const ImplicitAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: buildAppBar(),
      body: LocationsWidget(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

class LocationsWidget extends StatefulWidget {
  const LocationsWidget({super.key});

  @override
  State<LocationsWidget> createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  final PageController pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: 4,
            itemBuilder: (context, index) {
              final locationId = index + 1;
              return LocationWidget(locationId: locationId);
            },
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}

AppBar buildAppBar() => AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text('Implicit Animations'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {},
        ),
      ],
    );

BottomNavigationBar buildBottomNavigationBar() => BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.transparent,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Colors.transparent,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
          backgroundColor: Colors.transparent,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.transparent,
        ),
      ],
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    );

class LocationWidget extends StatefulWidget {
  final int locationId;

  const LocationWidget({super.key, required this.locationId});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double expandedBottomPaddingBackGroundWidget = 40;
    const double notExpandedBottomPaddingBackGroundWidget = 100;
    const int millisecondsDuration = 500;

    final double expandedWidthBackGroundWidget = size.width * 0.8;
    final double notExpandedWidthBackGroundWidget = size.width * 0.7;

    final double expandedHeightBackGroundWidget = size.height * 0.6;
    final double notExpandedHeightBackGroundWidget = size.height * 0.5;

    final double opacityBackgroundWidget = isExpanded ? 1 : 0.2;

    const double expandedBottomPaddingImageWidget = 150;
    const double notExpandedBottomPaddingImageWidget =
        100; // Same as notExpandedBottomPaddingBackGroundWidget

    // If the background widget starts at 40 expanded and the bottom padding of the image widget starts at 150 expanded, the difference is 110.
    const double heightDifference = expandedBottomPaddingImageWidget -
        expandedBottomPaddingBackGroundWidget; // 110

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: millisecondsDuration),
          bottom: isExpanded
              ? expandedBottomPaddingBackGroundWidget
              : notExpandedBottomPaddingBackGroundWidget,
          width: isExpanded
              ? expandedWidthBackGroundWidget
              : notExpandedWidthBackGroundWidget,
          height: isExpanded
              ? expandedHeightBackGroundWidget
              : notExpandedHeightBackGroundWidget,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: millisecondsDuration),
            opacity: opacityBackgroundWidget,
            child: ExpandedContentWidget(
              locationId: widget.locationId,
              isExpanded: isExpanded,
              height: heightDifference,
              width: isExpanded
                  ? expandedWidthBackGroundWidget
                  : notExpandedWidthBackGroundWidget,
              duration: millisecondsDuration,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: millisecondsDuration),
          bottom: isExpanded
              ? expandedBottomPaddingImageWidget
              : notExpandedBottomPaddingImageWidget,
          child: GestureDetector(
            onPanUpdate: onPanUpdate,
            child: ImageWidget(locationId: widget.locationId),
          ),
        ),
      ],
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    } else {
      setState(() {
        isExpanded = true;
      });
    }
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.locationId,
  });

  final int locationId;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    const Set<String> imagesTitles = {
      'Tortas',
      'Frappés',
      'Desayunos',
      'Cenas'
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            // assets\images\1.png (From 1 to 4)
            image: AssetImage(
              'assets/images/$locationId.png',
            ),
            // image: NetworkImage(
            //   'https://picsum.photos/id/${locationId + 100}/200/300',
            // ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(
            //   'assets/images/location_$locationId.jpg',
            //   height: 200,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            // CircleAvatar(
            //   radius: 50,
            //   backgroundColor: Colors.green[500],
            //   child: Text(
            //     locationId.toString(),
            //     style: Theme.of(context).textTheme.titleLarge,
            //   ),
            // ),
            // const SizedBox(height: 16),
            Text(
              imagesTitles.elementAt(locationId - 1),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Ordenar ahora',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandedContentWidget extends StatelessWidget {
  const ExpandedContentWidget({
    super.key,
    required this.locationId,
    required this.isExpanded,
    required this.height,
    required this.width,
    required this.duration,
  });

  final int locationId;
  final bool isExpanded;
  final double height;
  final double width;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedContainer(
          duration: Duration(milliseconds: duration),
          color: Colors.black,
          height: height,
          width: width,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.vertical,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.yellow,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
