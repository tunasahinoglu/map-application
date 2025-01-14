import 'package:bolu/screen/widgets/side_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:bolu/model/place_model.dart';
import 'package:bolu/repo/place_repo.dart';
import 'package:bolu/screen/widgets/drawer.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final LatLng _initialPosition = const LatLng(40.7627, 31.6049);
  final double _initialZoom = 11.0;
  final double _placeZoomLevel = 15.0;

  LatLng _currentPosition = const LatLng(40.7627, 31.6049);
  double _currentZoom = 11.0;

  final MapController _mapController = MapController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPanelOpen = false;
  String _currentPlaceName = '';
  String _currentPlaceDescription = '';
  String _currentImagePath = '';
  List<String> _currentSideImages = [];

  late AnimationController _panelController;
  late Animation<Offset> _panelAnimation;

  @override
  void initState() {
    super.initState();
    _panelController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _panelAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _panelController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _panelController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
      if (_isPanelOpen) {
        _panelController.forward();
      } else {
        _panelController.reverse();
      }
    });
  }

  void _resetToInitialPosition() {
    _animateMapMove(_initialPosition, _initialZoom);
  }

  void _animateMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
      begin: _currentPosition.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: _currentPosition.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: _currentZoom,
      end: destZoom,
    );

    var controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      setState(() {
        _currentPosition = LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        );
        _currentZoom = zoomTween.evaluate(animation);
        _mapController.move(_currentPosition, _currentZoom);
      });
    });

    controller.forward();
  }

  void _updateCurrentPlaceInfo(Place place) {
    setState(() {
      _currentPlaceName = place.name;
      _currentPlaceDescription = place.description;
      _currentImagePath = place.imagePath;
      _currentSideImages = place.sideImages;
    });
    _animateMapMove(place.coordinates, _placeZoomLevel);
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerScrimColor: Colors.transparent,
      drawer: DrawerWidget(
        currentPlaceName: _currentPlaceName,
        currentPlaceDescription: _currentPlaceDescription,
        currentImagePath: _currentImagePath,
        onReturnHome: () {
          Navigator.of(context).pop();
          _resetToInitialPosition();
        },
      ),
      onDrawerChanged: (isOpen) {
        if (isOpen) {
          _togglePanel();
        } else {
          _resetToInitialPosition();
          _togglePanel();
        }
      },
      body: GestureDetector(
        onTap: _resetToInitialPosition,
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition,
                initialZoom: _currentZoom,
                onPositionChanged: (position, hasGesture) {
                  setState(() {
                    _currentPosition = position.center;
                    _currentZoom = position.zoom;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  tileProvider: CancellableNetworkTileProvider(),
                ),
                MarkerLayer(
                  markers: [
                    for (var place in placeList)
                      Marker(
                        point: place.coordinates,
                        width: 80.0,
                        height: 80.0,
                        child: GestureDetector(
                          onTap: () => _updateCurrentPlaceInfo(place),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                              Expanded(child: Text(place.name, textAlign: TextAlign.center,))
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            if (_scaffoldKey.currentState?.isDrawerOpen ?? false)
              SidePanelWidget(
                panelAnimation: _panelAnimation,
                currentSideImages: _currentSideImages,
              ),
          ],
        ),
      ),
    );
  }
}
