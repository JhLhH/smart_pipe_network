import 'package:smartpipenetwork/models/location_model_entity.dart';

locationModelEntityFromJson(LocationModelEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['regeocode'] != null) {
		data.regeocode = new LocationModelRegeocode().fromJson(json['regeocode']);
	}
	if (json['info'] != null) {
		data.info = json['info']?.toString();
	}
	if (json['infocode'] != null) {
		data.infocode = json['infocode']?.toString();
	}
	return data;
}

Map<String, dynamic> locationModelEntityToJson(LocationModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	if (entity.regeocode != null) {
		data['regeocode'] = entity.regeocode.toJson();
	}
	data['info'] = entity.info;
	data['infocode'] = entity.infocode;
	return data;
}

locationModelRegeocodeFromJson(LocationModelRegeocode data, Map<String, dynamic> json) {
	if (json['addressComponent'] != null) {
		data.addressComponent = new LocationModelRegeocodeAddressComponent().fromJson(json['addressComponent']);
	}
	if (json['formatted_address'] != null) {
		data.formattedAddress = json['formatted_address']?.toString();
	}
	return data;
}

Map<String, dynamic> locationModelRegeocodeToJson(LocationModelRegeocode entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.addressComponent != null) {
		data['addressComponent'] = entity.addressComponent.toJson();
	}
	data['formatted_address'] = entity.formattedAddress;
	return data;
}

locationModelRegeocodeAddressComponentFromJson(LocationModelRegeocodeAddressComponent data, Map<String, dynamic> json) {
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['province'] != null) {
		data.province = json['province']?.toString();
	}
	if (json['adcode'] != null) {
		data.adcode = json['adcode']?.toString();
	}
	if (json['district'] != null) {
		data.district = json['district']?.toString();
	}
	if (json['towncode'] != null) {
		data.towncode = json['towncode']?.toString();
	}
	if (json['streetNumber'] != null) {
		data.streetNumber = new LocationModelRegeocodeAddressComponentStreetNumber().fromJson(json['streetNumber']);
	}
	if (json['country'] != null) {
		data.country = json['country']?.toString();
	}
	if (json['township'] != null) {
		data.township = json['township']?.toString();
	}
	if (json['businessAreas'] != null) {
		data.businessAreas = json['businessAreas'];
	}
	if (json['building'] != null) {
		data.building = new LocationModelRegeocodeAddressComponentBuilding().fromJson(json['building']);
	}
	if (json['neighborhood'] != null) {
		data.neighborhood = new LocationModelRegeocodeAddressComponentNeighborhood().fromJson(json['neighborhood']);
	}
	if (json['citycode'] != null) {
		data.citycode = json['citycode']?.toString();
	}
	return data;
}

Map<String, dynamic> locationModelRegeocodeAddressComponentToJson(LocationModelRegeocodeAddressComponent entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['city'] = entity.city;
	data['province'] = entity.province;
	data['adcode'] = entity.adcode;
	data['district'] = entity.district;
	data['towncode'] = entity.towncode;
	if (entity.streetNumber != null) {
		data['streetNumber'] = entity.streetNumber.toJson();
	}
	data['country'] = entity.country;
	data['township'] = entity.township;
	data['businessAreas'] = entity.businessAreas;
	if (entity.building != null) {
		data['building'] = entity.building.toJson();
	}
	if (entity.neighborhood != null) {
		data['neighborhood'] = entity.neighborhood.toJson();
	}
	data['citycode'] = entity.citycode;
	return data;
}

locationModelRegeocodeAddressComponentStreetNumberFromJson(LocationModelRegeocodeAddressComponentStreetNumber data, Map<String, dynamic> json) {
	if (json['number'] != null) {
		data.number = json['number'];
	}
	if (json['direction'] != null) {
		data.direction = json['direction'];
	}
	if (json['distance'] != null) {
		data.distance = json['distance'];
	}
	if (json['street'] != null) {
		data.street = json['street'];
	}
	return data;
}

Map<String, dynamic> locationModelRegeocodeAddressComponentStreetNumberToJson(LocationModelRegeocodeAddressComponentStreetNumber entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['number'] = entity.number;
	data['direction'] = entity.direction;
	data['distance'] = entity.distance;
	data['street'] = entity.street;
	return data;
}

locationModelRegeocodeAddressComponentBuildingFromJson(LocationModelRegeocodeAddressComponentBuilding data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'];
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	return data;
}

Map<String, dynamic> locationModelRegeocodeAddressComponentBuildingToJson(LocationModelRegeocodeAddressComponentBuilding entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['type'] = entity.type;
	return data;
}

locationModelRegeocodeAddressComponentNeighborhoodFromJson(LocationModelRegeocodeAddressComponentNeighborhood data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'];
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	return data;
}

Map<String, dynamic> locationModelRegeocodeAddressComponentNeighborhoodToJson(LocationModelRegeocodeAddressComponentNeighborhood entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['type'] = entity.type;
	return data;
}