import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget {
  double initialZoom;
  MapWidget({super.key, required this.initialZoom});

  @override
  State<MapWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myPosition == null? const Center(child: CircularProgressIndicator()) : FlutterMap(
      options: MapOptions(
        initialCenter: myPosition!,
        initialZoom: 15.8,
      ),
      mapController: MapController(),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        // RichAttributionWidget(
        //   animationConfig: const ScaleRAWA(),
        //   attributions: [
        //     TextSourceAttribution(
        //       'OpenStreetMap contributors',
        //       onTap: () => Uri.parse('https://openstreetmap.org/copyright'),
        //     ),
        //   ],
        // ),
        MarkerLayer(
          markers: [
            Marker(
                point: myPosition!,
                width: 30,
                height: 30,
                rotate: true,
                child: Icon(
                  Icons.location_on,
                  size: 30,
                  color: AppTheme().theme().primaryColor,
                ))
          ],
        )
      ],
    );
  }
}
