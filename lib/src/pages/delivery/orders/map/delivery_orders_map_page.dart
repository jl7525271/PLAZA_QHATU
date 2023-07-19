import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_finder/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';


class DeliveryOrdersMapPage extends StatefulWidget {
  const DeliveryOrdersMapPage({super.key});

  @override
  State<DeliveryOrdersMapPage> createState() => _DeliveryOrdersMapPageState();
}


class _DeliveryOrdersMapPageState extends State<DeliveryOrdersMapPage> {

  DeliveryOrdersMapController _con = new  DeliveryOrdersMapController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _googleMaps(),

          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonSelect(),
          )
        ],
      ),
    );
  }

  Widget _buttonSelect() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed:_con.selectRefPoint,
        child: Text(
          'Seleccionar esta direccion',
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primaryColor,
        ),
      ),
    );
  }


  Widget _googleMaps () {
    return GoogleMap(
    mapType: MapType.normal,
    initialCameraPosition: _con.initialPosition,
    onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),

    );
  }

  void refresh () {
    setState(() {});
  }
}


