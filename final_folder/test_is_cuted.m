function  test( img )
%TEST Summary of this function goes here
%   ֻ�г�Բ�� ���ڴ��������
%   Detailed explanation goes here

%��Բcanny���ӵõ���Ե
%img_canny_in=canny_in(img);

%����hough�㷨��Բ����
I=img;
edge_in = edge(I,'canny',0.89);
[hough_space_in,hough_circle_in,para_in] = SHT(edge_in,1,0.05,20,80,0.9);  %�����趨ԭ����ֱ�ۻ�ã����Ԫ��СԪ�뾶�趨��
[pline_x_in,pline_y_in]=recreatcurve(para_in,I);       %�����Բ��plot

BW_out=im2bw(I,0.65);  %��ֵ���õ�������Ե
edge_out=canny_out_BW(BW_out);
[hough_space_out,hough_circle_out,para_out] = SHT(edge_out,1,0.05,100,140,1);  %�����趨ԭ����ֱ�ۻ�ã����Ԫ��СԪ�뾶�趨��
[pline_x_out,pline_y_out]=recreatcurve(para_out,I);

imshow(I);
title('��ȡԲ��')
 hold on;
 plot(pline_y_in,pline_x_in,'.');
 hold on;
 plot(pline_y_out,pline_x_out,'.');
 
 img_cut=wipeout(img,para_in,para_out);   %�س���Ĥͼ��
%  imshow(img_cut); 