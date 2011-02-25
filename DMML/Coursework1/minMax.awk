### Com and crime -  99 non class, 100 total
### yeast  - 8 non class, 9 total
### authors - 65 non class, 66 total 
### indians - 8 non class, 9 total
BEGIN{
  records=0; 
  fields=66;
}

{
  records++;
  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END{


  for(i=1;i<fields;i++) {max[i] = 0; min[i] = data[1,i]; range[i]=0;}
  
 ####### Find maxs and mins
  for(r=1;r<=records;r++){
    for(f=1;f<fields;f++){
      if(data[r,f] > max[f]){
        max[f] = data[r,f];
      }
      if(data[r,f] < min[f]){
        min[f] = data[r,f];
      }
    }
  }
  ##### Calculate ranges
  for(i=1;i<fields;i++) {range[i]= max[i] - min[i];}

  ##### calculate min-max 
  for(r=1;r<=records;r++){
    for(f=1;f<fields;f++){
      data[r,f] = ((data[r,f] - min[f])/ range[f])*100;
    }
  }

  ##### finally, print out the new dataset
  for(r=1;r<=records;r++) {
    for(f=1;f<=fields;f++) {
      printf("%s ", data[r,f]);
    }
    printf("\n");
  }


} 
