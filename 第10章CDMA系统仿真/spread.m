%��Ƶ����
function[out]=spread(data,code)
%DSCDMA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   data :������������
%   code :��Ƶ������
%   out :�����������

switch nargin
case{0,1} %�����������������ԣ�����
error('ȱ���������');
end

[hn,vn] = size(data);
[hc,vc] = size(code);

if hn>hc %��Ƶ����С������Ĵ���Ƶ�������У�����
    error('ȱ����Ƶ������');
end

out = zeros(hn,vn*vc);

for ii=1:hn
    out(ii,:)=reshape(code(ii,:).'*data(ii,:),1,vn*vc);
end