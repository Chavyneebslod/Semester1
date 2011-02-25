BEGIN {records = 0; numfields = 100;}
{
  records++;
  for(i=1;i<=NF;i++)
    {data[records,i] = $i;}
}
END{
  for(r=1;r<=records;r++){
    data[r,numfields] = int(data[r,numfields]*10)+1;
    if( data[r,numfields] == 11){
       data[r,numfields] = 10;
    }
  }
  for(r=1;r<=records;r++){
    for(f=1;f<=numfields;f++){
      printf("%s ", data[r,f]);
    }
  printf("\n");
  }
  
}

