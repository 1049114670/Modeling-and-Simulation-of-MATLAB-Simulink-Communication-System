clear all
m = 4;
n = 2^m-1; %���ֳ���
N = 100; %��Ϣ����
k = 5; %��Ϣ����
msg = randi([0,1],N,k); %��Ϣ����
[genpoly,t] = bchgenpoly(n,k); %(15,5)BCH��ľ�������

code = bchenc(gf(msg),n,k); %BCH����
noisycode = code+randerr(N,n,1:t); %ÿ�����ּ��벻������������������
[newmsg,err,ccode] = bchdec(noisycode,n,k); %����
if code==ccode
    disp('���д�����ض���������');
end
if msg==newmsg
    disp('������Ϣ��ԭ��Ϣ��ͬ');
end