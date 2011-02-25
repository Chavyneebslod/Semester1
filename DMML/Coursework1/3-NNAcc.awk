### Com and crime -  99 non class, 100 total
### yeast  - 8 non class, 9 total
### authors - 65 non class, 66 total 
### indians - 8 non class, 9 total
BEGIN{ 
  records=0;
  fields=66;
  correct=0;
}

{
  records++;
  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END{

   for(m=1;m<=records;m++){
     currentRec = m;
     closestDiff1=1000000;
     closestDiff2=1000000;
     closestDiff3=1000000;
     closestRec1=-1;
     closestRec2=-1; 
     closestRec3=-1;
     for(r=1;r<=records;r++){
       currentDiff=0;
       if(r != currentRec){
         for(f=1;f<fields;f++){
           currentDiff = currentDiff + (data[m,f] - data[r,f]);
         }
         currentDiff = currentDiff^2;
         if(currentDiff < closestDiff1){
           closestDiff1 = currentDiff1;
           closestRec1 = r;
         }
         else if(currentDiff < closestDiff2){
             closestDiff2 = currentDiff2;
             closestRec2 = r;
         }
         else if(currentDiff < closestDiff3){
             closestDiff3 = currentDiff3;
             closestRec3 = r;
           
         }

 
         
       } 
     }hypothesisClass = determineClass(closestRec1, closestRec2, closestRec3);
     if(data[m,fields] == hypothesisClass){
       correct++;
     }

   }

  accuracy = 100*correct/records;

  print accuracy;

}

function determineClass(rec1, rec2, rec3){
  hypothesis = data[rec1,fields];
  if(data[rec2,fields] == hypothesis){
    return hypothesis;
  }else{
    hypothesis = data[rec2,fields];
  }

  if(hypothesis == data[rec3,fields]){
    return hypothesis;
  }else{
   return data[rec3,fields];
  } 
   
}





