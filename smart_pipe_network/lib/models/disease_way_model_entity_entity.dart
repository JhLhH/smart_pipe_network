import 'package:smartpipenetwork/generated/json/base/json_convert_content.dart';

class DiseaseWayModelEntityEntity with JsonConvert<DiseaseWayModelEntityEntity> {
	bool ret;
	String msg;
	List<DiseaseWayModelEntityResult> result;
}

class DiseaseWayModelEntityResult with JsonConvert<DiseaseWayModelEntityResult> {
	String name;
	String id;
}
