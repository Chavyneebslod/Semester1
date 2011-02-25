##### first initialise a "remove" array, to say nothing gets removed
BEGIN {numfields = 10; for(i=1;i<=numfields;i++) {remove[i]=0;}
#####  now indicate specific fields to remove
  remove[1] = 1;
}
{
  for(i=1;i<=NF;i++) 
    { if(remove[i]==0) {printf("%s ", $i);}}
  printf("\n");
}

