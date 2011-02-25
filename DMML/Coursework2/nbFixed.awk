# this script assumes that the data is space separated, and that
# all fields except the last are numeric
BEGIN {records = 0; bins =10;}
{
  records++;
  if(records==1) {numfields = NF;}

  for(i=1;i<=NF;i++) {data[records,i] = $i;}
}
END {  train = int(0.8*records); print train;
##### initialise max and mins
  for(i=1;i<numfields;i++) {max[i] = data[1,i]; min[i] = data[1,i];}
##### calculate max and mins
  for(i=1;i<numfields;i++) {
    for(r=1;r<=train;r++) { 
      if(data[r,i]<min[i]) {min[i] = data[r,i];}
      if(data[r,i]>max[i]) {max[i] = data[r,i];}
  }
  }
#### calculate ranges
    for(i=1;i<numfields;i++) {range[i] = max[i]-min[i];}
#### calculate bin widths
    for(i=1;i<numfields;i++) {binwidth[i] = range[i]/bins;}

#### how many classes are there?
###### initialise as 1 class, which is class value of record 1
    nclasses = 1;
    classes[1] = data[1,numfields];
###### find out how many classes and what they are
    for(i=2;i<=records;i++)
      { new = 1;
        for(c=1;c<=nclasses;c++) {if(data[i,numfields]==classes[c]) {new=0;}}
        if(new==1) { nclasses++; classes[nclasses] = data[i,numfields];}}

##### get the class counts -- how many in each class -- we will use this
##### later
    for(c=1;c<=nclasses;c++) {classcounts[c]=0;}
    for(r=1;r<=train;r++)
      { for(c=1;c<=nclasses;c++)
	  {if(data[r,numfields]==classes[c]) {classcounts[c]++;}}}

    for(c=1;c<=nclasses;c++)
      {print "class",classes[c],classcounts[c],classcounts[c]/train;}

###### for each class for each field, calculate the proportions of
###### values in each bin
########## initialise the counts
    for(c = 1; c <= nclasses; c++)
      { for(f=1;f<numfields;f++)
	{ 
             for(b=1;b<=bins;b++) 
	       {  count[c,f,b] = 0;}
	}
	}
###### now go through and populate the counts
    for(r=1;r<=train;r++)
      { ### get the class
        for(c=1;c<=nclasses;c++) 
	  { if (data[r,numfields]==classes[c]) thisclass = c;}
	for(f=1;f<numfields;f++)
	  {
	    for(b=1;b<=bins;b++)
	      { x = data[r,f];
                {mini = min[f] + (b-1)*binwidth[f];
		  maxi = min[f] + b * binwidth[f];
		  if(b==bins) {maxi+= 1.0;}

		  if ((x>= mini) && (x <maxi)) {count[thisclass,f,b]++;}
	      }
	  }
      }
      }

###### now work out the proportions
    for(c = 1; c <= nclasses; c++)
      { if(classcounts[c]==0) {classcounts[c]=1;}
           for(f=1;f<numfields;f++)
	{ 
             for(b=1;b<=bins;b++) 
	       {  count[c,f,b] /= classcounts[c]; print classes[c],f,b,count[c,f,b];}
	}
      }

#### now what is the performance of Naive Bayes on these data?
    correct = 0;
    for(c=1;c<=nclasses;c++) {for(d=1;d<=nclasses;d++) {confused[c,d]=0;}}
    for(r=train+1;r<=records;r++)
      {
	print "calculating performance on test data: record", r;
	for(c=1;c<=nclasses;c++) {prob[c] = 0;}
        for(c=1;c<=nclasses;c++)
	  { #### prob of class c is initialised by prior prob of class
            p = log(classcounts[c]/train);
            for(f=1;f<numfields;f++) 
	      {#### find the bin of this value 
               
	    for(b=1;b<=bins;b++)
	      { x = data[r,f];
                {mini = min[f] + (b-1)*binwidth[f];
		  maxi = min[f] + b * binwidth[f];
		  if(b==bins) {maxi+= 1.0;}

		  if ((x>= mini) && (x <maxi)) {thisbin = b;}
		}
	      }
	      
	    p += log(count[c,f,thisbin]);
	      }
	      
	      prob[c] = p;
	  }
     ##### which class is most likely ?
	bestclass = 1; 
	for(c=2;c<=nclasses;c++) {
          if(prob[c]>prob[bestclass]){
            bestclass=c;
          }
        }
	if(data[r,numfields]==classes[bestclass]){
          correct++;
        }
        ##### CHANGE
        #find the position of the guessed class in classes
        position = 0;
        target = data[r,numfields];
        for(i=1;i<=nclasses;i++){
          if(classes[i] ==  data[r,numfields]){
            position = i;
            break;
          }
        }
        # CHANGE 
        #use position along with the index of the best class to increment a portion of the confusion matrix.
        confused[position,bestclass]++;
      }
    printf("overall accuracy on test set is %g per cent\n", 
	   100*correct/(records- train));
   
    ####### CHANGE -- Display the values of the class as well, makes the matrix harder to read
    #######           but also makes it easier to understand the results in the long term. 
    printf("\nconfusion matrix\n               predicted class\n");
    for(c=1;c<=nclasses;c++) {
      printf("actual class %d (value=%s): ",c,classes[c]);
            for(d=1;d<=nclasses;d++) {printf(" %d ", confused[c,d]);}
    printf("\n");
    }
}
