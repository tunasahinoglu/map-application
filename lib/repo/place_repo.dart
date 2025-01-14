import 'package:bolu/model/place_model.dart';
import 'package:latlong2/latlong.dart';

final List<Place> placeList = [
  Place(
    name: "Gölcük",
    coordinates: const LatLng(40.654581, 31.626999),
    description: "Gölcük Tabiat Parkı",
    imagePath: 'assets/golcuk.jpg',
    sideImages: ['assets/golcuk.jpg', 'assets/golcuk2.jpg'],
  ),
  Place(
    name: "Abant",
    coordinates: const LatLng(40.60441, 31.28237),
    description: "Abant Gölü",
    imagePath: 'assets/abant.jpg',
    sideImages: ['assets/abant.jpg', 'assets/abant2.jpg'],
  ),
  Place(
    name: "Yedigöller",
    coordinates: const LatLng(40.94201, 31.74639),
    description: "Yedigöller Tabiat Parkı",
    imagePath: 'assets/yedigoller.jpg',
    sideImages: ['assets/yedigoller.jpg', 'assets/yedigoller2.jpg'],
  ),
  Place(
    name: "Köroğlu Parkı",
    coordinates: const LatLng(40.749785, 31.570952),
    description: "Uluslararası Türk Dünyası Köroğlu Parkı",
    imagePath: 'assets/koroglu.jpg',
    sideImages: ['assets/koroglu.jpg', 'assets/koroglu2.jpg'],
  ),
  Place(
    name: "Demokrasi Meydanı",
    coordinates: const LatLng(40.732852, 31.608492),
    description: "Demokrasi Meydanı",
    imagePath: 'assets/demokrasi.jpg',
    sideImages: ['assets/demokrasi.jpg', 'assets/demokrasi2.jpg'],
  ),
];