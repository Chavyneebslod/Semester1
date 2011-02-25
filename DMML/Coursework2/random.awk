BEGIN {
  records = 0; numfields = 100;
  collision = 200;
}
{
  records++;
  for(i=1;i<=NF;i++){
    data[records,i] = $i;
  }
  notDone[records] = 1;
}
END{
  srand();
  num = records/2;
  while(num >0 && collision >0){
    x=int((rand()*records)+1);
    if(notDone[x] == 1){
      notDone[x] =0;
      for(f=1;f<=numfields;f++){
        printf("%s ",data[x,f]);
      }
      printf("\n");
      num--;       
    }else{collision--;}
  }
  for(r=1;r<=records;r++){
    if(notDone[r] == 1){
      for(f=1;f<=numfields;f++){
        printf("%s ",data[r,f]);
      }
      printf("\n");
      notDone[x] =0;
    }
  } 
  
} 
