import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';

class LoginModelEntity with JsonConvert<LoginModelEntity> {
	bool ret;
	String msg;
	LoginModelResult result;
}

class LoginModelResult with JsonConvert<LoginModelResult> {
	List<String> appPermissions;
	List<dynamic> permissions;
	List<String> roles;
	String exipreTime;
	LoginModelResultConfig config;
	LoginModelResultUser user;
	String token;
}

class LoginModelResultConfig with JsonConvert<LoginModelResultConfig> {
	String userId;
	String theme;
	String layout;
	String multiPage;
	String fixSiderbar;
	String fixHeader;
	String color;
}

class LoginModelResultUser with JsonConvert<LoginModelResultUser> {
	String userId;
	String username;
	String password;
	String deptId;
	String deptName;
	String email;
	String mobile;
	String status;
	String createTime;
	dynamic modifyTime;
	String lastLoginTime;
	String ssex;
	dynamic description;
	String avatar;
	String realName;
	String roleId;
	String roleName;
	dynamic sortField;
	dynamic sortOrder;
	dynamic createTimeFrom;
	dynamic createTimeTo;
	String id;
	int authCacheKey;
}
