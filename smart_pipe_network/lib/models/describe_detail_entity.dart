import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';
import 'package:smartpipenetwork/generated/json/base/json_filed.dart';

class DescribeDetailEntity with JsonConvert<DescribeDetailEntity> {
	bool ret;
	String msg;
	DescribeDetailResult result;
}

class DescribeDetailResult with JsonConvert<DescribeDetailResult> {
	String id;
	String inspectorsId;
	String discoveryTime;// 发现时间
	String areaName;
	String wayId;// 道路id
	String createTime;
	String memo;
	String informationId;
	int submitStatus;
	dynamic completeTime;
	String submitTime;
	int dealStatus;
	List<DescribeDetailResultDescribe> describes;// 病害描述
	dynamic historyTasks;
	dynamic informationName;
	dynamic inspectorsName;
	@JSONField(name: "map")
	dynamic xMap;
}

class DescribeDetailResultDescribe with JsonConvert<DescribeDetailResultDescribe> {
	String id;
	String refDisease;
	String type;// 病害类型
	int number;// 病害数量
	String address;// 病害位置
	String reasonAnalysis;// 原因分析
	String renovationMeasures;// 整修措施
	String memo;
	String modifyTime;
}
