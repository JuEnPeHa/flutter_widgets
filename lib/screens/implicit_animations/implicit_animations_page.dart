import 'package:flutter/material.dart';

const Set<String> imagesTitles = {'Tortas', 'Frappés', 'Desayunos', 'Cenas'};

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
            child: ImageWidget(
              locationId: widget.locationId,
              isExpanded: isExpanded,
            ),
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
    } else if (details.delta.dy == 0 || details.delta.dy < 0) {
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
    required this.isExpanded,
  });

  final int locationId;
  final bool isExpanded;

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
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Text(
                    imagesTitles.elementAt(locationId - 1),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      )),
                  height: constraints.maxHeight * 0.2,
                  width: constraints.maxWidth,
                  // The child if isExpanded is "Desliza hacia arriba para ver más detalles" and if not is "Desliza hacia abajo para ocultar detalles" y una flecha hacia arriba o abajo
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              isExpanded
                                  ? 'Desliza hacia abajo para cerrar detalles'
                                  : 'Desliza hacia arriba para ver más detalles',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
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
    final String title = imagesTitles.elementAt(locationId - 1);
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedContainer(
          duration: Duration(milliseconds: duration),
          height: height,
          width: width,
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: height * 0.2,
                        width: (height * 0.2) * 5,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: (height * 0.2) - 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: (height * 0.2) - 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: (height * 0.2) - 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: (height * 0.2) - 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: (height * 0.2) - 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            // Revisar si la penultima letra es a o no
                            'Prueba nuestr' +
                                (title[title.length - 2] == 'a' ? 'as' : 'os') +
                                ' delicios' +
                                (title[title.length - 2] == 'a' ? 'as' : 'os') +
                                ' ' +
                                title.toLowerCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                        // Boton ver mas
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('Ver más',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            )),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
