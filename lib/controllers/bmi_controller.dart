import 'dart:math';



import 'package:bmi_calc/models/bmi_model.dart';
import 'package:bmi_calc/utilities/consts.dart';
import 'package:get/get.dart';



class BMIController extends GetxController {
  var selectedGender = Gender.none.obs;
  var age = 26.obs;
  var selectedHeightIndex = 0.obs;
  var selectedWeightIndex = 0.obs;
  var weight = 50.obs;
  var height = 160.obs;
  double bmi = 0.0;
  var result = ''.obs;
  var description = ''.obs;
  Rx<double> range = 255.0.obs;
  // BmiModel? bb = BmiModel();
 List<BmiModel> _bmiModelList=[];
 List<BmiModel> get bmiModelList => _bmiModelList;
 Rx<Gender> get gendertype => selectedGender;
// BmiModel bb=BmiModel(bmi: bmi.toDouble(), resultText: );
String  getGender (){
  if(selectedGender==Gender.male){
    return "male";
  }
  return "female";
}

 addbmi(BmiModel bmiModel){
  _bmiModelList.add(bmiModel);
  
  update();
 }
  void increaseAge() => age++;
  void decreaseAge() {
    if (age.value > 0) age--;
  }
  void increaseWeightt() => weight++;
  void decreaseWeight() {
    if (weight.value > 0) weight--;
  }
    void increaseheight() => height++;
  void decreaseheight() {
    if (height.value > 0) height--;
  }

  void selectGender(Gender gender) {
    selectedGender.value == gender;
  }

  void calculateBMI() {
    if (height != 0 && weight != 0 && selectedGender.value != Gender.none) {
      bmi = (weight / pow(height / 100, 2));
      _getResult();
    } else if (selectedGender.value == Gender.none) {
      Get.snackbar('Gender', 'Please select gender!');
    } else if (height == 0) {
      Get.snackbar('Height', 'Height cannot be 0, select a height!');
    } else if (weight == 0) {
      Get.snackbar('Weight', 'Weight cannot be 0, select a weight!');
    }
  }

  void _getResult() {
    if (bmi < 18.5) {
      result.value = 'Underweight';
    } else if (bmi > 18.5 && bmi < 24.9) {
      result.value = 'Healthy Weight';
    } else if (bmi > 25.0 && bmi < 29.9) {
      result.value = 'Overweight';
    } else {
      result.value = 'Obesity';
    }
   
  }

 

  void clearInfo() {
    selectedGender.value = Gender.none;
    age.value = 26;
    selectedHeightIndex.value = 0;
    selectedWeightIndex.value = 0;
    weight.value = 0;
    height.value = 0;
    bmi = 0.0;
    result.value = '';
  }


 
}
