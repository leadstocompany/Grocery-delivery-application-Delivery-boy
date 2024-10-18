import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;

  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBvbt_XselhEKjHeAihYwcWz0cGW8eVokw";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Positioned(
            top: 15,
            left: 20,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios_new)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),

                // borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20.h),
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.user),
                      Gap(5.h),
                      Container(
                        width: 130.w,
                        child: Text(
                          'Aman Sharma',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.subTitleStyle.copyWith(
                              color: context.appColor.blackColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: context.appColor.primarycolor,
                      ),
                      Gap(5.h),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.subTitleStyle.copyWith(
                                  color: context.appColor.blackColor,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '201/D, Ananta Apts, Near Jal Bhawan,\n Andheri 400069',
                              overflow: TextOverflow.ellipsis,
                              style: context.subTitleTextStyleBloack.copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                  SizedBox(
                      width: double.infinity,
                      child: ButtonElevated(
                          backgroundColor: context.appColor.primarycolor,
                          // : Icon(Icons.telegram_outlined),
                          leadingIcon: Icon(
                            Icons.telegram_outlined,
                            color: context.appColor.whiteColor,
                          ),
                          text: 'Start',
                          onPressed: () {})),
                  Gap(20.h),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
        origin: PointLatLng(_originLatitude, _originLongitude),
        destination: PointLatLng(_destLatitude, _destLongitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
