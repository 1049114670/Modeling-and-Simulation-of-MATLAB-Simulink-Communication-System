clear all
N = 10000;
k = 4; %������Ϣ���س���
n = 7; %�������ֳ���
x = randi([0,1],N*k,1); %��Ϣ����
code = encode(x,n,k); %(7,4)Hamming�����
code1 = matintrlv(code,N/10,10*n); %(N/10,10*n)����֯
noise = randerr(N,n,[0:n-3;0.8 0.09 0.07 0.03 0.01]); %�ŵ����������������������
noise = reshape(noise.',N*n,1);
y = bitxor(code,noise); %�޽�֯�����ź�
y = decode(y,n,k); %Hamming������
[err ber] = biterr(x,y); %ͳ���������

y1 = bitxor(code1,noise); %��֯�����ź�
y1 = matdeintrlv(y1,N/10,10*n); %�⽻֯
y1 = decode(y1,n,k); %Hamming������
[err ber1] = biterr(x,y1); %ͳ���������

disp('�޽�֯ʱ���������');
ber
disp('��֯ʱ���������');
ber1

