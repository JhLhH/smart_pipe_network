import 'package:smartpipenetwork/models/detailes_images_entity.dart';

detailesImagesEntityFromJson(DetailesImagesEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['result'] != null) {
		data.result = new List<DetailesImagesResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new DetailesImagesResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> detailesImagesEntityToJson(DetailesImagesEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['msg'] = entity.msg;
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

detailesImagesResultFromJson(DetailesImagesResult data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['size'] != null) {
		data.size = json['size']?.toInt();
	}
	if (json['path'] != null) {
		data.path = json['path']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['extName'] != null) {
		data.extName = json['extName']?.toString();
	}
	if (json['refBizType'] != null) {
		data.refBizType = json['refBizType']?.toString();
	}
	if (json['refBizId'] != null) {
		data.refBizId = json['refBizId']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['modifyTime'] != null) {
		data.modifyTime = json['modifyTime']?.toString();
	}
	if (json['memo'] != null) {
		data.memo = json['memo'];
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	return data;
}

Map<String, dynamic> detailesImagesResultToJson(DetailesImagesResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['size'] = entity.size;
	data['path'] = entity.path;
	data['type'] = entity.type;
	data['extName'] = entity.extName;
	data['refBizType'] = entity.refBizType;
	data['refBizId'] = entity.refBizId;
	data['createTime'] = entity.createTime;
	data['modifyTime'] = entity.modifyTime;
	data['memo'] = entity.memo;
	data['url'] = entity.url;
	return data;
}