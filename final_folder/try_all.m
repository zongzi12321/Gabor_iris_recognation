listing = dir('01/*.bmp');
for i = 380:size(listing,1)
    imgName = listing(i).name
    str = ['01/',imgName];
   
     if exist(str,'file')
         imgData = imread(str);
          a{i}=test_gamma(imgData);
          str = ['01/',imgName]
          ss=i
            pause;
     end
  %获得欧氏距离矩阵查看各个特征值之间的距离
%   for i=1:size(a,2)
%       for j=1:size(a,2)
%           if norm(a{i}-a{j})/200-1<0;
%               result(i,j)=1;
%           else
%               result(i,j)=0;
%           end
%         qq(i,j)=norm(a{i}-a{j})/200-1;
%       end
%   end
%      
end