import 'package:latlong2/latlong.dart';

class Place {
  final String name;
  final LatLng coordinates;
  final String description;
  final String imagePath;
  final List<String> sideImages;

  Place({
    required this.name,
    required this.coordinates,
    required this.description,
    required this.imagePath,
    required this.sideImages,
  });
}
