import 'package:flutter/material.dart';

class ImplicitAnimationsPage extends StatelessWidget {
  const ImplicitAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
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
            itemCount: 5,
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

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1500),
          bottom: isExpanded ? 40 : 100,
          width: isExpanded ? size.width * 0.8 : size.width * 0.7,
          height: isExpanded ? size.height * 0.6 : size.height * 0.5,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1500),
            opacity: isExpanded ? 1 : 0.2,
            child: ExpandedContentWidget(
              locationId: widget.locationId,
              isExpanded: isExpanded,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1500),
          bottom: isExpanded ? 150 : 100,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              'https://picsum.photos/id/${locationId + 100}/200/300',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
            Text('Location ${locationId}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 8),
            Text(
              'This is a description of location ${locationId}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Learn More'),
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
  });

  final int locationId;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        color: Colors.black,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
            Text('Location ${locationId}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 8),
            Text(
              'This is a description of location ${locationId}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('Learn More'),
            // ),
          ],
        ),
      ),
    );
  }
}
