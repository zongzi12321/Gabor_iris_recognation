function img_new = wipeout(img,mean_circle_in,mean_circle_out)
%------------------------------�������-----------------------------
%   img : ԭʼͼ��
%   mean_circle_in�� �ָ���Բ�Ĳ���
%   mean_circle_out���ָ���Բ�Ĳ���     
%          ������ʽ��   mean_circle(1) : Բ�ĺ�����
%                      mean_circle(2) ��Բ��������
%                      mean_circle(3) ��Բ�İ뾶    
%                 
%------------------------------�������-----------------------------------
%    img_new���·ָ�ͼ��
%[600 800]
[line,row]=size(img);  %ȡ��С
for i = 1:line
    for j = 1:row     %�������
        dis = sqrt((i-mean_circle_out(1)).^2+(j-mean_circle_out(2)).^2);
        if dis > mean_circle_out(3)   %�ȽϾ����С����Բȡ����
            img(i,j) = 255;
        end
    end
end
for i = 1:line
    for j = 1:row      %�������
        dis1 = sqrt((i-mean_circle_in(1)).^2+(j-mean_circle_in(2)).^2);
        if dis1 < mean_circle_in(3)     %�ȽϾ����С����ԲȡС��
            img(i,j) = 255;
        end
    end
end
img_new = img;