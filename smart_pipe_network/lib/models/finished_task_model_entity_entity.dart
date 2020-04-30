import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';

class FinishedTaskModelEntityEntity with JsonConvert<FinishedTaskModelEntityEntity> {
	bool ret;
	String msg;
	List<FinishedTaskModelEntityResult> result;
}

class FinishedTaskModelEntityResult with JsonConvert<FinishedTaskModelEntityResult> {
	String id;
	String name;
	String plantId;
	String areaName;
	String rummagerId;
	double status;
	String generateTime;
	String startTime;
	String endTime;
	dynamic realStartTime;
	dynamic realEndTime;
	String memo;
	List<String> rummagerName;
	String plantName;
	dynamic track;
}
