import 'package:smartpipenetwork/models/finished_task_model_entity_entity.dart';

finishedTaskModelEntityEntityFromJson(FinishedTaskModelEntityEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['result'] != null) {
		data.result = new List<FinishedTaskModelEntityResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new FinishedTaskModelEntityResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> finishedTaskModelEntityEntityToJson(FinishedTaskModelEntityEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['msg'] = entity.msg;
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

finishedTaskModelEntityResultFromJson(FinishedTaskModelEntityResult data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['plantId'] != null) {
		data.plantId = json['plantId']?.toString();
	}
	if (json['areaName'] != null) {
		data.areaName = json['areaName']?.toString();
	}
	if (json['rummagerId'] != null) {
		data.rummagerId = json['rummagerId']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toDouble();
	}
	if (json['generateTime'] != null) {
		data.generateTime = json['generateTime']?.toString();
	}
	if (json['startTime'] != null) {
		data.startTime = json['startTime']?.toString();
	}
	if (json['endTime'] != null) {
		data.endTime = json['endTime']?.toString();
	}
	if (json['realStartTime'] != null) {
		data.realStartTime = json['realStartTime'];
	}
	if (json['realEndTime'] != null) {
		data.realEndTime = json['realEndTime'];
	}
	if (json['memo'] != null) {
		data.memo = json['memo']?.toString();
	}
	if (json['rummagerName'] != null) {
		data.rummagerName = json['rummagerName']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['plantName'] != null) {
		data.plantName = json['plantName']?.toString();
	}
	if (json['track'] != null) {
		data.track = json['track'];
	}
	return data;
}

Map<String, dynamic> finishedTaskModelEntityResultToJson(FinishedTaskModelEntityResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['plantId'] = entity.plantId;
	data['areaName'] = entity.areaName;
	data['rummagerId'] = entity.rummagerId;
	data['status'] = entity.status;
	data['generateTime'] = entity.generateTime;
	data['startTime'] = entity.startTime;
	data['endTime'] = entity.endTime;
	data['realStartTime'] = entity.realStartTime;
	data['realEndTime'] = entity.realEndTime;
	data['memo'] = entity.memo;
	data['rummagerName'] = entity.rummagerName;
	data['plantName'] = entity.plantName;
	data['track'] = entity.track;
	return data;
}