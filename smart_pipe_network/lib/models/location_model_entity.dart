import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';
import 'package:smartpipenetwork/generated/json/base/json_filed.dart';

class LocationModelEntity with JsonConvert<LocationModelEntity> {
	String status;
	LocationModelRegeocode regeocode;
	String info;
	String infocode;
}

class LocationModelRegeocode with JsonConvert<LocationModelRegeocode> {
	LocationModelRegeocodeAddressComponent addressComponent;
	@JSONField(name: "formatted_address")
	String formattedAddress;
}

class LocationModelRegeocodeAddressComponent with JsonConvert<LocationModelRegeocodeAddressComponent> {
	String city;
	String province;
	String adcode;
	String district;
	String towncode;
	LocationModelRegeocodeAddressComponentStreetNumber streetNumber;
	String country;
	String township;
	dynamic businessAreas;
	LocationModelRegeocodeAddressComponentBuilding building;
	LocationModelRegeocodeAddressComponentNeighborhood neighborhood;
	String citycode;
}

class LocationModelRegeocodeAddressComponentStreetNumber with JsonConvert<LocationModelRegeocodeAddressComponentStreetNumber> {
	dynamic number;
	dynamic direction;
	dynamic distance;
	dynamic street;
}

class LocationModelRegeocodeAddressComponentBuilding with JsonConvert<LocationModelRegeocodeAddressComponentBuilding> {
	dynamic name;
	dynamic type;
}

class LocationModelRegeocodeAddressComponentNeighborhood with JsonConvert<LocationModelRegeocodeAddressComponentNeighborhood> {
	dynamic name;
	dynamic type;
}
