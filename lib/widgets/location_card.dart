import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ofimex/widgets/dialog.dart';
import 'package:readmore/readmore.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
   LatLng? myPosition;
  bool _isLoading = true;
  String? _errorMessage;
  String? _address; // Variable para almacenar la dirección obtenida

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress(); // Obtener ubicación y dirección
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() {
        _errorMessage = 'El servicio de ubicación no está habilitado.';
        _isLoading = false;
      });
      return Future.error(_errorMessage!);
    }

    permission = await Geolocator.checkPermission();

    // Solicitar permiso si está denegado
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = 'El permiso de ubicación fue denegado.';
          _isLoading = false;
        });
        return Future.error(_errorMessage!);
      }
    }

    // Manejar permiso denegado para siempre
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage = 'El permiso de ubicación está denegado permanentemente.';
        _isLoading = false;
      });
      return Future.error(_errorMessage!);
    }

    // Obtener la posición actual
    return await Geolocator.getCurrentPosition();
  }

  void _getCurrentLocationAndAddress() async {
    try {
      // Obtener la posición actual
      Position position = await _determinePosition();
      LatLng newPosition = LatLng(position.latitude, position.longitude);

      // Obtener dirección desde las coordenadas
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = placemarks.isNotEmpty
          ? '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}, ${placemarks[0].postalCode}'
          : 'Dirección no disponible';

      setState(() {
        myPosition = newPosition;
        _address = address; // Guardar la dirección obtenida
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener ubicación o dirección: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/map");
      },
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              
              SizedBox(width: 100,height: 100,child:  _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? CustomDialog(mensaje: _errorMessage ?? "No hay mensaje", onPressed: _getCurrentLocationAndAddress)
                : FlutterMap(
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tu ubicación",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppTheme().theme().primaryColor,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _address ?? "Dirección no disponible",
                      
                      // overflow: TextOverflow.ellipsis,
                      // style: Theme.of(context).textTheme.labelLarge,
                    ),
                    // Text(
                    //   "Teziutlan, Puebla",
                    //   style: Theme.of(context).textTheme.labelLarge,
                    // )
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
