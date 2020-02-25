function species = classifier( features )
%classifier the function receives feature matrix
% as input and gives out the classified species of the 
% input tumor
load Trainset.mat
 xdata = meas;
 group = label;
 svmStruct1 = svmtrain(xdata,group,'kernel_function', 'linear');
 species = svmclassify(svmStruct1,features,'showplot',false);
 
 if strcmpi(species,'MALIGNANT')
     helpdlg(' Malignant Tumor ');
 else
     helpdlg(' Benign Tumor ');
 end

end

