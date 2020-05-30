import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';

class UndoneTaskModelEntity with JsonConvert<UndoneTaskModelEntity> {
	bool ret;
	String msg;
	List<UndoneTaskModelResult> result;
}

class UndoneTaskModelResult with JsonConvert<UndoneTaskModelResult> {
	String id;
	String name;
	String plantId;
	String areaName;
	String rummagerId;
	int status;
	String generateTime;
	String startTime;
	String createTime;
	String endTime;
	dynamic realStartTime;
	dynamic realEndTime;
	String memo;
	String taskPeriod;
	String rummagerName;
	String plantName;
	dynamic track;
}
