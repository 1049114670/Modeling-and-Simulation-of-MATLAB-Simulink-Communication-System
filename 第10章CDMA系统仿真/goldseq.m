function [gout] = goldseq(m1,m2,num)
%GOLDSEQ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   m1:m����1
%   m2:m����2
%   num�����ɵ�Gold���и���
%   gout�����ɵ�Gold�������
if nargin < 3  %���û��ָ�����ɵ�Gol���и�����Ĭ��Ϊ1
    num = 1;
end
gout =zeros(num,length(m1));
for ii=1:num %����Gold�������ɷ�������Gold����
    gout(ii,:) = xor(m1,m2);
    m2 = shift(m2,1);
end

