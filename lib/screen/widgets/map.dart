import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:bolu/model/place_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final List<Place> placeList;
  final Function(Place) updatePlaceInfo;

  const MapWidget({super.key, 
    required this.mapController,
    required this.placeList,
    required this.updatePlaceInfo,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(40.41239, 30.81768),
        initialZoom: 12.0,
        onPositionChanged: (position, hasGesture) {
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
                  onTap: () => updatePlaceInfo(place),
                  child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
