function  test( img )
%TEST Summary of this function goes here
%   只切除圆环 用于处理问题的
%   Detailed explanation goes here

%内圆canny算子得到边缘
%img_canny_in=canny_in(img);

%调用hough算法内圆参数
I=img;
edge_in = edge(I,'canny',0.89);
[hough_space_in,hough_circle_in,para_in] = SHT(edge_in,1,0.05,20,80,0.9);  %参数设定原因是直观获得（最大元最小元半径设定）
[pline_x_in,pline_y_in]=recreatcurve(para_in,I);       %获得内圆的plot

BW_out=im2bw(I,0.65);  %二值化得到清晰边缘
edge_out=canny_out_BW(BW_out);
[hough_space_out,hough_circle_out,para_out] = SHT(edge_out,1,0.05,100,140,1);  %参数设定原因是直观获得（最大元最小元半径设定）
[pline_x_out,pline_y_out]=recreatcurve(para_out,I);

imshow(I);
title('截取圆环')
 hold on;
 plot(pline_y_in,pline_x_in,'.');
 hold on;
 plot(pline_y_out,pline_x_out,'.');
 
 img_cut=wipeout(img,para_in,para_out);   %截除虹膜图像
%  imshow(img_cut); 