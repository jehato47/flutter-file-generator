import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final LatLng latLng;
  const MapScreen({Key? key, required final this.latLng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LatLng cor = widget.latLng;
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        // polylines: {
        //   Polyline(
        //     width: 5,
        //     polylineId: PolylineId("12"),
        //     points: markers,
        //     color: Colors.grey,
        //     geodesic: true,
        //   ),
        // },
        // myLocationButtonEnabled: false,
        myLocationEnabled: true,
        trafficEnabled: true,
        onTap: (argument) {
          // setState(() {
          //   Marker marker = Marker(
          //     markerId: MarkerId("new_marker"),
          //     position: LatLng(argument.latitude, argument.longitude),
          //     draggable: true,
          //   );
          //   markers.add(marker);

          //   target = LatLng(argument.latitude, argument.longitude);
          // });
          // print(markers.length);
        },
        markers: {Marker(markerId: MarkerId("1"), position: latLng)},
        mapType: MapType.hybrid,

        initialCameraPosition: CameraPosition(
          zoom: 12,
          target: latLng,
        ),
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
      ),
    );
  }
}
