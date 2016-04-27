listing = dir('01/*.bmp');
out=cell(2,296);
for i = 1:296
    imgName = listing(i).name
    str = ['01/',imgName];
   
     if exist(str,'file')
         imgData = imread(str);
         [featureVector,I,img_cut,add,polar_array,J,gaborArrayout]=test_gamma(imgData);
         out{1,i}=imgName;
         out{2,i}=featureVector;
     
          pause(0.05);
     end
end