BEGIN{
  fields=9;
  records=0;
}

{
  records++;
  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}

END{
  for(r=1;r<=records;r++){
    if(data[r,fields] != "CYT" ){
      data[r,fields] = "OTHER";
    }
  }

  for(r=1;r<=records;r++) {
    for(f=1;f<=fields;f++) {
      printf("%s ", data[r,f]);
    }
    printf("\n");
  }

}
