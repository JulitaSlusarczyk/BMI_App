
String calculateBMI(double height, double weight, bool imperialUnits){
  if(imperialUnits){
    return ((weight/(height*height))*703).toStringAsFixed(2);
  }
  height = height/100;
  return (weight/(height*height)).toStringAsFixed(2);
}