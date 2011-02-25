### first initialise a "remove" array, to say nothing gets removed
BEGIN {numfields = 99; for(i=1;i<=numfields;i++) {remove[i]=1;}
  remove[44] = 0;
  remove[50] = 0;
  remove[43] = 0;
  remove[4] = 0;
  remove[45] = 0;
# remove[46] = 0;
# remove[3] = 0;
# remove[18] = 0;
# remove[16] = 0;
# remove[40] = 0;
#  remove[41] = 0;
#  remove[38] = 0;
#  remove[67] = 0;
#  remove[28] = 0;
#  remove[32] = 0;
#  remove[77] = 0;
#  remove[30] = 0;
#  remove[74] = 0;
#  remove[69] = 0;
#  remove[49] = 0;
}

{
  for(i=1;i<=NF;i++)
    { if(remove[i]==0) {printf("%s ", $i);}}
  printf("\n");
}


