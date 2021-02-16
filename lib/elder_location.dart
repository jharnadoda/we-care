import 'package:we_care/location.dart';
import 'package:we_care/constants.dart';
import 'package:we_care/network.dart';

class ElderLocation {
  String address, url;
  UserLocation location;
  ElderLocation();
  getLocationData() async {
    location = UserLocation(longitude: 0, latitude: 0);
    await location.getLocation().then((value) {
      location = value;
    });
    String uri =
        'https://api.opencagedata.com/geocode/v1/json?q=${location.latitude}+${location.longitude}&key=$kOpenCageApiKey';
    NetworkHelper networkHelper = NetworkHelper(uri);
    var data;
    await networkHelper.getData().then((value) {
      data = value;
    });
    this.url = data['results'][0]['annotations']['OSM']['url'];
    this.address = data['results'][0]['formatted'];
    return this;
  }
}
