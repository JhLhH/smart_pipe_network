import 'package:smartpipenetwork/models/disease_way_model_entity_entity.dart';

diseaseWayModelEntityEntityFromJson(DiseaseWayModelEntityEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['result'] != null) {
		data.result = new List<DiseaseWayModelEntityResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new DiseaseWayModelEntityResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> diseaseWayModelEntityEntityToJson(DiseaseWayModelEntityEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['msg'] = entity.msg;
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

diseaseWayModelEntityResultFromJson(DiseaseWayModelEntityResult data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	return data;
}

Map<String, dynamic> diseaseWayModelEntityResultToJson(DiseaseWayModelEntityResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}