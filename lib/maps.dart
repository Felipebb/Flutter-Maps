import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const LatLng _center = const LatLng(-30.027680, -51.228640);
  LatLng _lastMapPosition = _center;


  Future<void> _onCameraMove(CameraPosition position) async {
    //Posicao atual
    _lastMapPosition = position.target;
    print(_lastMapPosition);
     GoogleMapController controller = await  _controller.future;
    LatLngBounds latLngBounds = await controller.getVisibleRegion();
    print("NorthEast: ${latLngBounds.northeast.latitude}, ${latLngBounds.northeast.longitude}. SouthWest: ${latLngBounds.southwest.latitude}, ${latLngBounds.southwest.longitude}");
  }

  void _onMapCreated(GoogleMapController controller) async  {
    _controller.complete(controller);
    LatLngBounds latLngBounds = await controller.getVisibleRegion();
    //Bordas
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("NorthEast: ${latLngBounds.northeast.latitude}, ${latLngBounds.northeast.longitude}. SouthWest: ${latLngBounds.southwest.latitude}, ${latLngBounds.southwest.longitude}")));
    print(latLngBounds.southwest);
    print(latLngBounds.northeast);
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = List <Marker>();
    markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(-30.027680, -51.228640),
          infoWindow: InfoWindow(
              title: "Marcador",
              snippet: "Personalizado",
              onTap: () {
              }),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        )
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Google Maps e Marcadores'),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: Set.from(markers),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              onCameraMove: _onCameraMove,
            ),
          ],
        ),
      ),
    );
  }
}