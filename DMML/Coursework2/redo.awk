BEGIN {records = 0; numfields = 100;}
{
  records++;
  for(i=1;i<=NF;i++)
    {data[records,i] = $i;}

}
END{
  for(r=1;r<=records;r++){
    data[r,numfields]--;
    for(f=1;f<=numfields;f++){
      printf("%s ", data[r,f]);
    }
  printf("\n");
  }


}
