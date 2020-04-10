function [mout] = mseq(n,taps,inidata,num)
%MSEQ �˴���ʾ�йش˺�����ժҪ
%   n:m���еĽ���
%   taps:�����Ĵ���������λ��
%   inidata:�Ĵ����ĳ�ʼ����
%   num:���m���еĸ���
%   mout:�����m���У����num>1,���һ��Ϊһ��m����
if nargin < 4
    num = 1;
end

mout = zeros(num,2^n-1);
fops = zeros(n,1);
fops(taps) = 1;

for ii=1:2^n-1
    mout(1,ii) = inidata(n);  %�Ĵ������������
    temp = mod(inidata*fops,1);  %���㷴������
    inidata(2:n) = inidata(1:n-1); %�Ĵ�����λһ��
    inidata(1) = temp; %���µ�һ���Ĵ�����ֵ
end

if num > 1
    for ii=2:num
        mout(ii,:) = shift(mout(ii-1,:),1);
    end
end
end

