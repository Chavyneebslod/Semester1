BEGIN {records = 0; numfields = 100;}
{
  records++;
    for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END { 
##### initialise means and stds
  for(i=1;i<=numfields;i++) {mean[i] = 0; std[i] = 0;}
##### calculate means 
  for(f=1;f<=numfields;f++) {
    for(r=1;r<=records;r++) {
      mean[f] += data[r,f];
    }
    mean[f] /= records;
  }
##### subtract means from the values
  for(r=1;r<=records;r++) {
    for(f=1;f<numfields;f++) { #### note "<" not "<=" ... 
      data[r,f] -= mean[f];    #### leaving the class field intact
    }
  }
##### calculate stds
  for(f=1;f<numfields;f++) {
    for(r=1;r<=records;r++) {
      std[f] += (data[r,f]*data[r,f]);
    }
    std[f] /= records;
    std[f] = sqrt(std[f]);
  }
##### replace each value by std units
  for(r=1;r<=records;r++) {
    for(f=1;f<numfields;f++) {
      data[r,f] /= std[f];
    }
  }
  
##### finally, print out the new dataset
  for(r=1;r<=records;r++) {
    for(f=1;f<=numfields;f++) {
      printf("%s ", data[r,f]);
    }
    printf("\n");
  }
}