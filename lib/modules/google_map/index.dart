import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/models/map_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/google_map/google_map_bloc.dart';

final class GoogleMapPage extends StatefulWidget {
  static const String routeName = '/google-map';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => GoogleMapBloc()..add(GetInfoMap(MapParam.now)),
          child: const GoogleMapPage(),
        );
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _mapController;

  final double defaultZoom = 15;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  final LatLng center = LatLng(
    double.parse(MapParam.now.pointerlatitude),
    double.parse(MapParam.now.pointerlongtitude),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              _mapController?.animateCamera(CameraUpdate.newLatLngZoom(center, defaultZoom));
            },
            icon: const Icon(Icons.pin_drop_outlined, size: 25),
          ),
        ],
        elevation: 1,
        title: Text(
          MapParam.now.hotelName,
          style: context.text.displayMedium,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
          builder: (context, state) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: center, zoom: defaultZoom),
              markers: state.markers.isNotEmpty
                  ? state.markers
                  : {
                      Marker(
                        markerId: MarkerId(MapParam.now.hotelName),
                        position: LatLng(
                          double.parse(MapParam.now.pointerlatitude),
                          double.parse(MapParam.now.pointerlongtitude),
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                        infoWindow: InfoWindow(
                          title: MapParam.now.hotelName,
                        ),
                      ),
                    },
            );
          },
        ),
      ),
    );
  }
}
