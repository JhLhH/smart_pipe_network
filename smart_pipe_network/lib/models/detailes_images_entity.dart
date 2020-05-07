import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';

class DetailesImagesEntity with JsonConvert<DetailesImagesEntity> {
	bool ret;
	String msg;
	List<DetailesImagesResult> result;
}

class DetailesImagesResult with JsonConvert<DetailesImagesResult> {
	String id;
	String name;
	int size;
	String path;
	String type;
	String extName;
	String refBizType;
	String refBizId;
	String createTime;
	String modifyTime;
	dynamic memo;
	String url;
}
