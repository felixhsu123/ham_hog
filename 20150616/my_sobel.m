%% ʹ��Sobel�㷨�����ݶȣ����Ĵ�С�ͷ������ͳ��
% OutImage��Сͳ��
% Vetor�ݶȷ���
function [OutImage, Vetor] = my_sobel(InImage)
[m,n] = size(InImage);
parray = zeros(1,9);
paramx = [-1 0 1 -2 0 2 -1 0 1];
paramy = [1 2 1 0 0 0 -1 -2 -1];
%��Ŵ�Сֵ
G = zeros(m,n);
%����ݶȷ���
O = zeros(m,n);
%% �������������
for i = 1:m
    for j = 1:n
        if i == 1 
            if j == 1
                parray(1,1) = InImage(i,j);
                parray(1,2) = InImage(i,j);
                parray(1,3) = InImage(i,j);
                parray(2,1) = InImage(i,j);
                parray(3,1) = InImage(i,j);

                parray(3,2) = InImage(i,j+1);
                parray(3,3) = InImage(i+1,j+1);
            elseif j == n
                parray(1,1) = InImage(i,j);
                parray(2,1) = InImage(i,j);
                parray(3,1) = InImage(i,j);
                parray(3,3) = InImage(i,j);
                parray(3,2) = InImage(i,j);

                parray(1,2) = InImage(i,j-1);
                parray(1,3) = InImage(i+1,j-1);
            else                    
                parray(1,1) = InImage(i,j-1);
                parray(2,1) = InImage(i,j);
                parray(3,1) = InImage(i,j+1);

                parray(1,2) = InImage(i,j-1);
                parray(1,3) = InImage(i+1,j-1);
                parray(3,3) = InImage(i+1,j+1);
                parray(3,2) = InImage(i,j+1);
            end
            parray(2,2) = InImage(i,j);
            parray(2,3) = InImage(i+1,j);
        elseif i==m
            if j == 1
                parray(1,1) = InImage(i,j);
                parray(1,2) = InImage(i,j);
                parray(1,3) = InImage(i,j);
                parray(2,3) = InImage(i,j);
                parray(3,3) = InImage(i,j);

                parray(3,2) = InImage(i,j+1);
                parray(3,1) = InImage(i-1,j+1);
            elseif j == n
                parray(1,3) = InImage(i,j);
                parray(2,3) = InImage(i,j);
                parray(3,3) = InImage(i,j);
                parray(3,1) = InImage(i,j);
                parray(3,2) = InImage(i,j);

                parray(1,1) = InImage(i-1,j-1);
                parray(1,2) = InImage(i,j-1);
            else                    
                parray(1,3) = InImage(i,j-1);
                parray(2,3) = InImage(i,j);
                parray(3,3) = InImage(i,j+1);

                parray(1,1) = InImage(i-1,j-1);
                parray(1,2) = InImage(i,j-1);
                parray(3,1) = InImage(i-1,j+1);
                parray(3,2) = InImage(i,j+1);
            end
            parray(2,2) = InImage(i,j);
            parray(2,1) = InImage(i-1,j);
        else
            if j == 1
                parray(1,1) = InImage(i-1,j);
                parray(1,2) = InImage(i,j);
                parray(1,3) = InImage(i+1,j);
                parray(3,1) = InImage(i-1,j+1);
                parray(3,2) = InImage(i,j+1);
                parray(3,3) = InImage(i+1,j+1);
            elseif j == n
                parray(3,1) = InImage(i-1,j);
                parray(3,2) = InImage(i,j);
                parray(3,3) = InImage(i+1,j);
                parray(1,1) = InImage(i-1,j-1);
                parray(1,2) = InImage(i,j-1);
                parray(1,3) = InImage(i+1,j-1);
            else                    
            parray(1,1) = InImage(i-1,j-1);
            parray(1,2) = InImage(i,j-1);
            parray(1,3) = InImage(i+1,j-1);
            parray(3,3) = InImage(i+1,j+1);
            parray(3,2) = InImage(i,j+1);
            parray(3,1) = InImage(i-1,j+1);
            end
            parray(2,1) = InImage(i-1,j);
            parray(2,2) = InImage(i,j);
            parray(2,3) = InImage(i+1,j);
%             parray(1,1) = InImage(i-1,j-1);
%             parray(2,1) = InImage(i-1,j);
%             parray(3,1) = InImage(i-1,j+1);
%             parray(1,2) = InImage(i,j-1);
%             parray(1,3) = InImage(i+1,j-1);
%             parray(3,3) = InImage(i+1,j+1);
%             parray(3,2) = InImage(i,j+1);
%             parray(2,2) = InImage(i,j);
%             parray(2,3) = InImage(i+1,j);
        end      
       %�����С      
       %����һ
       tmpx = 0;
       tmpy = 0;
       for k = 1:9
           tmpx = tmpx+ paramx(1,k)*parray(1,k);
           tmpy = tmpy+ paramy(1,k)*parray(1,k);
       end     
       G(i,j) = abs(tmpx)+abs(tmpy);
       %������
       %G(i,j) = abs((parray(1,1)+2*parray(1,2)+parray(1,3))-(parray(1,7)+2*parray(1,8)+parray(1,9)))+abs((parray(1,3)+2*parray(1,6)+parray(1,9))-(parray(1,1)+2*parray(1,4)+parray(1,7)));
       %���㷽��
       O(i,j) = atan(abs(tmpx/tmpy));
    end
end
OutImage = G;
Vetor = O;
end