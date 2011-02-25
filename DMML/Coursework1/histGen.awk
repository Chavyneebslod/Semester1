### Com and crime -  99 non class, 100 total
### yeast  - 8 non class, 9 total
### authors - 65 non class, 66 total 
### indians - 8 non class, 9 total
BEGIN{
  records=0;
  fields=100;
  target=0;
  otherTarget=7
  bin1=0
  bin2=0
  bin3=0
  bin4=0
  bin5=0

  bin21=0
  bin22=0
  bin23=0
  bin24=0
  bin25=0

  targetField=5
}

{
  records++;
  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END{
  for(r=1;r<=records;r++){
    if(data[r,fields] == target){
      if(data[r,targetField]*100<20){
        bin1++;
      }else if(data[r,targetField]*100<40){
        bin2++
      }else if(data[r,targetField]*100<60){
        bin3++
      }else if(data[r,targetField]*100<80){
        bin4++
      }else if(data[r,targetField]*100<100){
        bin5++
      }

    }else{
        otherTarget = data[r,fields];
        if(data[r,targetField]*100<20){
        bin21++;
      }else if(data[r,targetField]*100<40){
        bin22++
      }else if(data[r,targetField]*100<60){
        bin23++
      }else if(data[r,targetField]*100<80){
        bin24++
      }else if(data[r,targetField]*100<100){
        bin25++
      }
    }
  }
   totalBin1 = bin1+bin2+bin3+bin4+bin5
   bin1 = (bin1/totalBin1)*100
   bin2 = (bin2/totalBin1)*100
   bin3 = (bin3/totalBin1)*100
   bin4 = (bin4/totalBin1)*100
   bin5 = (bin5/totalBin1)*100
  
   totalBin2 = bin21+bin22+bin23+bin24+bin25
   bin21 = (bin21/totalBin2)*100
   bin22 = (bin22/totalBin2)*100
   bin23 = (bin23/totalBin2)*100
   bin24 = (bin24/totalBin2)*100
   bin25 = (bin25/totalBin2)*100
   
   printf("Class %s\n", target);
   
   printf("%s\n%s\n%s\n%s\n%s\n", bin1,bin2,bin3,bin4,bin5);
   print "\n"

   printf("Class %s\n", otherTarget );
   printf("%s\n%s\n%s\n%s\n%s\n", bin21,bin22,bin23,bin24,bin25);
}

