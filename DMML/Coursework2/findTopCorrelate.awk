BEGIN {
  records = 0; numfields = 100;
  constant =1;
}
{
  records++;
  for(i=1;i<=NF;i++){
    data[records,i] = $i;
    Rnum[i] = 0;
    stdDev[i] =0;
    mean[i] = 0;
  }
}
END{
  #Work out the std deviation of the class field
    #work out mean first...
    classStdDev = 0;
    classMean =0;
    for(r=1;r<=records;r++){
      classMean = classMean + data[r,numfields];
    }
    classMean = classMean/records;
    sqSum = 0;
    for(r=1;r<=records;r++){
      sqSum = sqSum + (data[r,numfields] - classMean)^2;
    }
    sqSum = sqSum * (1/(records-constant));
    classStdDev = sqrt(sqSum);
    #printf("Class Mean: %s, StdDev: %s\n",classMean, classStdDev);  

  #for each field. (except the class)..
  #work out the std deviation and store in stdDev
  for(f=1;f<numfields;f++){
    fieldMean =0
    fieldSqSum=0

    for(r=1;r<=records;r++){
      fieldMean = fieldMean + data[r,f];
    }
    fieldMean = fieldMean/records;
   # printf("Field %s Mean: %s\n", f, fieldMean);
    mean[i] = fieldMean;
    for(r=1;r<=records;r++){
      fieldSqSum = fieldSqSum + (data[r,f] - fieldMean)^2;
    }
    fieldSqSum = fieldSqSum * (1/(records-constant));
    stdDev[f] = sqrt(fieldSqSum);
    #printf("Field %s StdDev: %s\n", f, stdDev[f]);
  }
  #calculate r and store it Rnum
  for(f=1;f<numfields;f++){
    rSum = 0;
    for(r=1;r<=records;r++){
      rSum = rSum + (((data[r,f] - mean[f])/stdDev[f]) * ((data[r,numfields] - classMean)/classStdDev));
    }
    Rnum[f] = rSum * (1/(records-1));
    #printf("Field %d: Pearson Number:  %s\n",f, Rnum[f]);
  }
  
  print "** TOP 20 FIELDS **"
  for(i=1;i<21;i++){
    max = Rnum[1]^2;
    maxindex =1;
    for(x=2;x<numfields;x++){
    #  printf("Max: %s compared to %s\n", max,Rnum[i]);
      if(Rnum[x]^2 > max){
      #  print "Entered loop\n"
        max = Rnum[x]^2;
        maxindex = x;
      }
    }
    max = Rnum[maxindex];
    Rnum[maxindex] = 0;
    top20[i] = maxindex
    printf("Field %d  %s, with r: %s\n",i,top20[i], max);
  }
  
}

  
