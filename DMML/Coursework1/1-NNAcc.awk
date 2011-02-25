### Com and crime -  99 non class, 100 total
### yeast  - 8 non class, 9 total
### authors - 65 non class, 66 total 
### indians - 8 non class, 9 total
BEGIN{ 
  records=0;
  fields=9;
  correct=0;
  field1 =3;
  field2 =5;
}

{
  records++;
  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END{

   for(m=1;m<=records;m++){
     if( m % 100 == 1){ print m}
     currentRec = m;
     closestDiff=1000000;
     closestRec=-1;
     for(r=1;r<=records;r++){
       currentDiff=0;
       if(r != currentRec){
         for(f=1;f<fields;f++){
         #  if(f == field1 || f ==field2){
             currentDiff = currentDiff + (data[m,f] - data[r,f])^2;
          # }
         }
         currentDiff = currentDiff;
         if(currentDiff < closestDiff){
           closestDiff = currentDiff;
         closestRec = r;
         }
         
       } 
     }
     ## After finding the closest record in the set....
     if(data[m,fields] == data[closestRec,fields]){
       correct++; 
     }
   }

  accuracy = 100*correct/records;

  print accuracy;

}
