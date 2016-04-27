function  [featureVector,I,img_cut,add,polar_array,J,gaborArrayout]=test( img )
%TEST Summary of this function goes here
%集大成版
%   Detailed explanation goes here

%内圆canny算子得到边缘
%img_canny_in=canny_in(img);

%调用hough算法内圆参数
I=img;
edge_in = edge(I,'canny',0.89);
[hough_space_in,hough_circle_in,para_in] = SHT(edge_in,1,0.05,30,80,1);  %参数设定原因是直观获得（最大元最小元半径设定）
[pline_x_in,pline_y_in]=recreatcurve(para_in,I);       %获得内圆的plot

BW_out=adjgamma(I,0.3);  %gamma得到清晰边缘
edge_out=canny_out_BW(BW_out);
[hough_space_out,hough_circle_out,para_out] = SHT(edge_out,1,0.05,100,140,1);  %参数设定原因是直观获得（最大元最小元半径设定）
[pline_x_out,pline_y_out]=recreatcurve(para_out,I);
add={pline_x_out,pline_y_out,pline_x_in,pline_y_in};

% imshow(I);
% title('截取圆环')
%  hold on;
%  plot(pline_y_in,pline_x_in,'-');
%  hold on;
%  plot(pline_y_out,pline_x_out,'-');
 
 img_cut=wipeout(img,para_in,para_out);   %截除虹膜图像
%  imshow(img_cut); 
 
 [polar_array, polar_noise] = normaliseiris(img_cut,para_out(2),para_out(1),para_out(3),para_in(2),para_in(1),para_in(3),'zk1038',50,280);
%  figure();
%  imshow(polar_array);
 [J,T] = histeq(polar_array);  %直方图均衡化；
%  imshow(J);

 gaborArray = gaborFilterBank(5,8,39,39);
 gaborArrayout=gaborArray(4);
 featureVector = gaborFeatures(J,gaborArray,4,4);


end

