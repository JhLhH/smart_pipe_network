import 'package:smartpipenetwork/models/describe_detail_entity.dart';

describeDetailEntityFromJson(DescribeDetailEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['result'] != null) {
		data.result = new DescribeDetailResult().fromJson(json['result']);
	}
	return data;
}

Map<String, dynamic> describeDetailEntityToJson(DescribeDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['msg'] = entity.msg;
	if (entity.result != null) {
		data['result'] = entity.result.toJson();
	}
	return data;
}

describeDetailResultFromJson(DescribeDetailResult data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['inspectorsId'] != null) {
		data.inspectorsId = json['inspectorsId']?.toString();
	}
	if (json['discoveryTime'] != null) {
		data.discoveryTime = json['discoveryTime']?.toString();
	}
	if (json['areaName'] != null) {
		data.areaName = json['areaName']?.toString();
	}
	if (json['wayId'] != null) {
		data.wayId = json['wayId']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['memo'] != null) {
		data.memo = json['memo']?.toString();
	}
	if (json['informationId'] != null) {
		data.informationId = json['informationId']?.toString();
	}
	if (json['submitStatus'] != null) {
		data.submitStatus = json['submitStatus']?.toInt();
	}
	if (json['completeTime'] != null) {
		data.completeTime = json['completeTime'];
	}
	if (json['submitTime'] != null) {
		data.submitTime = json['submitTime']?.toString();
	}
	if (json['dealStatus'] != null) {
		data.dealStatus = json['dealStatus']?.toInt();
	}
	if (json['describes'] != null) {
		data.describes = new List<DescribeDetailResultDescribe>();
		(json['describes'] as List).forEach((v) {
			data.describes.add(new DescribeDetailResultDescribe().fromJson(v));
		});
	}
	if (json['historyTasks'] != null) {
		data.historyTasks = json['historyTasks'];
	}
	if (json['informationName'] != null) {
		data.informationName = json['informationName'];
	}
	if (json['inspectorsName'] != null) {
		data.inspectorsName = json['inspectorsName'];
	}
	if (json['map'] != null) {
		data.xMap = json['map'];
	}
	return data;
}

Map<String, dynamic> describeDetailResultToJson(DescribeDetailResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['inspectorsId'] = entity.inspectorsId;
	data['discoveryTime'] = entity.discoveryTime;
	data['areaName'] = entity.areaName;
	data['wayId'] = entity.wayId;
	data['createTime'] = entity.createTime;
	data['memo'] = entity.memo;
	data['informationId'] = entity.informationId;
	data['submitStatus'] = entity.submitStatus;
	data['completeTime'] = entity.completeTime;
	data['submitTime'] = entity.submitTime;
	data['dealStatus'] = entity.dealStatus;
	if (entity.describes != null) {
		data['describes'] =  entity.describes.map((v) => v.toJson()).toList();
	}
	data['historyTasks'] = entity.historyTasks;
	data['informationName'] = entity.informationName;
	data['inspectorsName'] = entity.inspectorsName;
	data['map'] = entity.xMap;
	return data;
}

describeDetailResultDescribeFromJson(DescribeDetailResultDescribe data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['refDisease'] != null) {
		data.refDisease = json['refDisease']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['number'] != null) {
		data.number = json['number']?.toInt();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['reasonAnalysis'] != null) {
		data.reasonAnalysis = json['reasonAnalysis']?.toString();
	}
	if (json['renovationMeasures'] != null) {
		data.renovationMeasures = json['renovationMeasures']?.toString();
	}
	if (json['memo'] != null) {
		data.memo = json['memo']?.toString();
	}
	if (json['modifyTime'] != null) {
		data.modifyTime = json['modifyTime']?.toString();
	}
	return data;
}

Map<String, dynamic> describeDetailResultDescribeToJson(DescribeDetailResultDescribe entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['refDisease'] = entity.refDisease;
	data['type'] = entity.type;
	data['number'] = entity.number;
	data['address'] = entity.address;
	data['reasonAnalysis'] = entity.reasonAnalysis;
	data['renovationMeasures'] = entity.renovationMeasures;
	data['memo'] = entity.memo;
	data['modifyTime'] = entity.modifyTime;
	return data;
}