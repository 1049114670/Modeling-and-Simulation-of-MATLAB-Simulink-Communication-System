clear all
m = 4;
n = 2^m-1; %���ֳ���
N = 10000; %��Ϣ����
k = 11; %��Ϣ����
t = (n-k)/2; %��������
msg = randi([0,1],N,k); %��Ϣ����
msg1 = gf(msg,m);
msg1 = rsenc(msg1,n,k).'; %(15,11)RS����
msg2 = de2bi(double(msg1.x),'left-msb'); %ת��Ϊ������
y = bsc(msg2,0.01); %ͨ�������ƶԳ��ŵ�
y = bi2de(y,'left-msb'); %ת��Ϊʮ����
y = reshape(y,n,N).';
dec_x = rsdec(gf(y,4),n,k); %RS����
[err,ber] = biterr(msg,double(dec_x.x),m); %�������������
