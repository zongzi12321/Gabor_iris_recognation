function BW2=canny(img)
I = img;  % 读入图像
% I=rgb2gray(I);               % 转化为灰色图像
% imshow(I);title('原图')
threshold = [0.004,0.02]; %设定阈值
%BW1 = edge(I,'canny',0.89);  % 调用canny函数 获取内圆
BW2 = edge(I,'canny',0.2,4);  % 调用canny函数 获取外圆
%figure,imshow(BW1);     % 显示分割后的图像，即梯度图像
% figure,imshow(BW2);     % 显示分割后的图像，即梯度图像
% title('matlab canny')