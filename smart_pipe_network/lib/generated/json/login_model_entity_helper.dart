import 'package:smartpipenetwork/models/login_model_entity.dart';

loginModelEntityFromJson(LoginModelEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['result'] != null) {
		data.result = new LoginModelResult().fromJson(json['result']);
	}
	return data;
}

Map<String, dynamic> loginModelEntityToJson(LoginModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['msg'] = entity.msg;
	if (entity.result != null) {
		data['result'] = entity.result.toJson();
	}
	return data;
}

loginModelResultFromJson(LoginModelResult data, Map<String, dynamic> json) {
	if (json['appPermissions'] != null) {
		data.appPermissions = json['appPermissions']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['permissions'] != null) {
		data.permissions = new List<dynamic>();
		data.permissions.addAll(json['permissions']);
	}
	if (json['roles'] != null) {
		data.roles = json['roles']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['exipreTime'] != null) {
		data.exipreTime = json['exipreTime']?.toString();
	}
	if (json['config'] != null) {
		data.config = new LoginModelResultConfig().fromJson(json['config']);
	}
	if (json['user'] != null) {
		data.user = new LoginModelResultUser().fromJson(json['user']);
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	return data;
}

Map<String, dynamic> loginModelResultToJson(LoginModelResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['appPermissions'] = entity.appPermissions;
	if (entity.permissions != null) {
		data['permissions'] =  [];
	}
	data['roles'] = entity.roles;
	data['exipreTime'] = entity.exipreTime;
	if (entity.config != null) {
		data['config'] = entity.config.toJson();
	}
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['token'] = entity.token;
	return data;
}

loginModelResultConfigFromJson(LoginModelResultConfig data, Map<String, dynamic> json) {
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['theme'] != null) {
		data.theme = json['theme']?.toString();
	}
	if (json['layout'] != null) {
		data.layout = json['layout']?.toString();
	}
	if (json['multiPage'] != null) {
		data.multiPage = json['multiPage']?.toString();
	}
	if (json['fixSiderbar'] != null) {
		data.fixSiderbar = json['fixSiderbar']?.toString();
	}
	if (json['fixHeader'] != null) {
		data.fixHeader = json['fixHeader']?.toString();
	}
	if (json['color'] != null) {
		data.color = json['color']?.toString();
	}
	return data;
}

Map<String, dynamic> loginModelResultConfigToJson(LoginModelResultConfig entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userId'] = entity.userId;
	data['theme'] = entity.theme;
	data['layout'] = entity.layout;
	data['multiPage'] = entity.multiPage;
	data['fixSiderbar'] = entity.fixSiderbar;
	data['fixHeader'] = entity.fixHeader;
	data['color'] = entity.color;
	return data;
}

loginModelResultUserFromJson(LoginModelResultUser data, Map<String, dynamic> json) {
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId']?.toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['modifyTime'] != null) {
		data.modifyTime = json['modifyTime'];
	}
	if (json['lastLoginTime'] != null) {
		data.lastLoginTime = json['lastLoginTime']?.toString();
	}
	if (json['ssex'] != null) {
		data.ssex = json['ssex']?.toString();
	}
	if (json['description'] != null) {
		data.description = json['description'];
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar']?.toString();
	}
	if (json['realName'] != null) {
		data.realName = json['realName']?.toString();
	}
	if (json['roleId'] != null) {
		data.roleId = json['roleId']?.toString();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName']?.toString();
	}
	if (json['sortField'] != null) {
		data.sortField = json['sortField'];
	}
	if (json['sortOrder'] != null) {
		data.sortOrder = json['sortOrder'];
	}
	if (json['createTimeFrom'] != null) {
		data.createTimeFrom = json['createTimeFrom'];
	}
	if (json['createTimeTo'] != null) {
		data.createTimeTo = json['createTimeTo'];
	}
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['authCacheKey'] != null) {
		data.authCacheKey = json['authCacheKey']?.toInt();
	}
	return data;
}

Map<String, dynamic> loginModelResultUserToJson(LoginModelResultUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	data['password'] = entity.password;
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['email'] = entity.email;
	data['mobile'] = entity.mobile;
	data['status'] = entity.status;
	data['createTime'] = entity.createTime;
	data['modifyTime'] = entity.modifyTime;
	data['lastLoginTime'] = entity.lastLoginTime;
	data['ssex'] = entity.ssex;
	data['description'] = entity.description;
	data['avatar'] = entity.avatar;
	data['realName'] = entity.realName;
	data['roleId'] = entity.roleId;
	data['roleName'] = entity.roleName;
	data['sortField'] = entity.sortField;
	data['sortOrder'] = entity.sortOrder;
	data['createTimeFrom'] = entity.createTimeFrom;
	data['createTimeTo'] = entity.createTimeTo;
	data['id'] = entity.id;
	data['authCacheKey'] = entity.authCacheKey;
	return data;
}