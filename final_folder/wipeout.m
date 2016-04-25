function img_new = wipeout(img,mean_circle_in,mean_circle_out)
%------------------------------输入参数-----------------------------
%   img : 原始图像
%   mean_circle_in： 分割内圆的参数
%   mean_circle_out：分割外圆的参数     
%          参数形式：   mean_circle(1) : 圆心横坐标
%                      mean_circle(2) ：圆心纵坐标
%                      mean_circle(3) ：圆的半径    
%                 
%------------------------------输出参数-----------------------------------
%    img_new：新分割图像
%[600 800]
[line,row]=size(img);  %取大小
for i = 1:line
    for j = 1:row     %计算距离
        dis = sqrt((i-mean_circle_out(1)).^2+(j-mean_circle_out(2)).^2);
        if dis > mean_circle_out(3)   %比较距离大小：外圆取大于
            img(i,j) = 255;
        end
    end
end
for i = 1:line
    for j = 1:row      %计算距离
        dis1 = sqrt((i-mean_circle_in(1)).^2+(j-mean_circle_in(2)).^2);
        if dis1 < mean_circle_in(3)     %比较距离大小：内圆取小于
            img(i,j) = 255;
        end
    end
end
img_new = img;