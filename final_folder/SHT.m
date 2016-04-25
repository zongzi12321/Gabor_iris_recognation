function [hough_space,hough_circle,para] = SHT(BW,step_r,step_angle,r_min,r_max,p)
% -----------------------------------------------------------------------------------
% Input
% BW:二值图像
% step_r:检测的圆半径步长
% step_angle:角度步长，单位为弧度
% r_min:最小圆半径
% r_max:最大圆半径
% p:阈值，0-1之间的数
%------------------------------------------------------------------------------------
% Output
% hough_space:参数空间，h(a,b,r)表示圆心在(a,b)半径为r的圆上的点数
% hough_circl:二值图像，检测到的圆
% para:检测到的圆的圆心、半径参数
%-------------------------------------------------------------------------------------
% IE ZJUT  
%-------------------------------------------------------------------------------------
[m,n] = size(BW);                       %图像的二维大小
size_r = round((r_max-r_min)/step_r)+1; %半径的总步长
size_angle = round(2*pi/step_angle);    %角度的总步长

hough_space = zeros(m,n,size_r);        %参数空间，三维累加器

[rows,cols] = find(BW==1);              %查找图像中的特征点
ecount = size(rows);                    %特征点个数

%Hough变换:将图像空间(x,y)对应到参数空间(a,b,r)，以每个特征点为圆心，在不同半径下画圆，画圆轨迹上的累加器值都加一
%a = x-r*cos(angle)
%b = y-r*sin(angle)
tic;
%Hough变换过程，可以看出计算复杂度O（N^3），存储复杂度是三维
for i=1:ecount                         
    for r=1:size_r
        for k=1:size_angle
            a = round(rows(i)-(r_min+(r-1)*step_r)*cos(k*step_angle));
            b = round(cols(i)-(r_min+(r-1)*step_r)*sin(k*step_angle));
            if(a>0 && a<=m && b>0 && b<=n)
                hough_space(a,b,r) = hough_space(a,b,r)+1;
            end
        end
    end
end

% 搜索超过阈值的聚集点,记下各个点的索引值
max_para = max(max(max(hough_space)));
index = find(hough_space>=max_para*p);

length = size(index);      %符合要求的聚类点个数
hough_circle = false(m,n); %构造一个与输入图像大小一样的二维二值数组,已检测到的参数在此图像上显示圆上的特征点
for k=1:length             %求出三个参数，k是圆的个数
    par3a = floor(index(k)/(m*n))+1;
    par2 = floor((index(k)-(par3a-1)*(m*n))/m)+1;
    par1 = index(k)-(par3a-1)*(m*n)-(par2-1)*m;
    par3b = r_min+(par3a-1)*step_r;
    para(:,k) = [par1,par2,par3b];
end

%显示已经检测到的圆，在一定的误差范围内的点都显示在此圆上
for i=1:ecount             
    for k=1:size(para,2)
        if(rows(i)-para(1,k))^2+(cols(i)-para(2,k))^2<(para(3,k)^2+16) && (rows(i)-para(1,k))^2+(cols(i)-para(2,k))^2>(para(3,k)^2-16)
            hough_circle(rows(i),cols(i)) = true;
        end
    end
end
toc;

%以一个8邻域表示圆心的位置
for k=1:size(para,2)
for i=para(1,k)-1:para(1,k)+1
    for j=para(2,k)-1:para(2,k)+1
        hough_circle(i,j) = true;
    end
end
%以检测到的圆的半径参数，查看hough_space参数空间在这个半径下的票数分布
end

% 打印检测结果
for i=1:size(para,2)
fprintf('Center %d %d radius %d\n',para(1,i),para(2,i),para(3,i));
end

