function BW2=canny(img)
I = img;  % ����ͼ��
% I=rgb2gray(I);               % ת��Ϊ��ɫͼ��
% imshow(I);title('ԭͼ')
threshold = [0.004,0.02]; %�趨��ֵ
%BW1 = edge(I,'canny',0.89);  % ����canny���� ��ȡ��Բ
BW2 = edge(I,'canny',0.2,4);  % ����canny���� ��ȡ��Բ
%figure,imshow(BW1);     % ��ʾ�ָ���ͼ�񣬼��ݶ�ͼ��
% figure,imshow(BW2);     % ��ʾ�ָ���ͼ�񣬼��ݶ�ͼ��
% title('matlab canny')