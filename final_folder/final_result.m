listing = dir('01/*.bmp');
for i = 1:30
    imgName = listing(i).name
    str = ['01/',imgName];
   
     if exist(str,'file')
         imgData = imread(str);
          test_is_cuted(imgData);
            pause(0.05);
     end
end