%����V-BLAST�ṹZF����㷨���ܣ����Ʒ�ʽΪQPSK
clear all
Nt = 4; %����������
Nr = 4; %����������
N = 10; %ÿ֡�ĳ���
L = 10000; %�������֡��
EbN0 = 0:2:20;
M = 4; %QPSK����
x = randi([0,1],N*L,Nt); %��Դ����
s = pskmod(x,M,pi/4); %QPSK����

for index=1:length(EbN0)
    s1 = [];
    s2 = [];
    s3 = [];
    for index1 = 1:L
        h = randn(Nt,Nr)+j*randn(Nt,Nr); %Rayleigh˥���ŵ�
        h = h./sqrt(2); %�ŵ�ϵ����һ��
        [q1,r1] = qr(h'); %�ŵ�QR�ֽ�
        r = r1(1:Nt,:)'; %����R
        q = q1(:,1:Nt)'; %����Q
        
        sigma1 = sqrt(1/(10.^(EbN0(index)/10))); %ÿ���������ߵĸ�˹��������׼��
        n = sigma1*(randn(N,Nr)+j*randn(N,Nr)); %ÿ���������ߵĸ�˹������
        
        y = s((index1-1)*N+1:index1*N,:)*h*q'+n*q'; %�ź�ͨ���ŵ�
        
        y1 = y*inv(r); %�޸�������ʱ��ZF���
        s1 = [s1;pskdemod(y1,M,pi/4)];
        
        %�и�������ʱ��ZF���
        y(:,Nt) = y(:,Nt)./(r(Nt,Nt)); %����Nt��
        y1(:,Nt) = pskdemod(y(:,Nt),M,pi/4); %�����Nt��
        y(:,Nt) = pskmod(y1(:,Nt),M,pi/4); %�Ե�Nt����������½��е���
        y2 = y;
        y3 = y1;
        for jj=Nt-1:-1:1
            for kk=jj+1:Nt
                y(:,jj) = y(:,jj)-r(kk,jj).*y(:,kk); %�������������
                y2(:,jj) = y2(:,jj)-r(kk,jj).*s((index1-1)*N+1:index1*N,kk); %�����������
            end
            y(:,jj) = y(:,jj)./r(jj,jj);
            y2(:,jj) = y2(:,jj)./r(jj,jj); %��jj���о�����
            y1(:,jj) = pskdemod(y(:,jj),M,pi/4); %��jj����н��
            y3(:,jj) = pskdemod(y2(:,jj),M,pi/4);
            y(:,jj) = pskmod(y1(:,jj),M,pi/4); %��jj���������½��е���
            y2(:,jj) = pskmod(y3(:,jj),M,pi/4);
        end
        s2 = [s2;y1];
        s3 = [s3;y3];
    end
    
    [temp,ber1(index)] = biterr(x,s1,log2(M)); %�޸�������ʱ��ϵͳ����
    [temp,ber2(index)] = biterr(x,s2,log2(M)); %�������������ʱ��ϵͳ����
    [temp,ber3(index)] = biterr(x,s3,log2(M)); %�����������ʱ��ϵͳ����
    
    [temp,ber24(index)] = biterr(x(:,1),s2(:,1),log2(M)); %�������������ʱ��4���ϵͳ����
    [temp,ber23(index)] = biterr(x(:,2),s2(:,2),log2(M)); %�������������ʱ��3���ϵͳ����
    [temp,ber22(index)] = biterr(x(:,3),s2(:,3),log2(M)); %�������������ʱ��2���ϵͳ����
    [temp,ber21(index)] = biterr(x(:,4),s2(:,4),log2(M)); %�������������ʱ��1���ϵͳ����
    
    [temp,ber34(index)] = biterr(x(:,1),s3(:,1),log2(M)); %�����������ʱ��4���ϵͳ����
    [temp,ber33(index)] = biterr(x(:,2),s3(:,2),log2(M)); %�����������ʱ��3���ϵͳ����
    [temp,ber32(index)] = biterr(x(:,3),s3(:,3),log2(M)); %�����������ʱ��2���ϵͳ����
    [temp,ber31(index)] = biterr(x(:,4),s3(:,4),log2(M)); %�����������ʱ��1���ϵͳ����
    
end

semilogy(EbN0,ber1,'-ko',EbN0,ber2,'-ro',EbN0,ber3,'-go')
title('V-BLAST�ṹZF����㷨����')
legend('�޸�������','�������������', '�����������')
xlabel('�����Eb/N0')
ylabel('������ʣ�BER��')

figure
semilogy(EbN0,ber34,'-ko',EbN0,ber33,'-ro',EbN0,ber32,'-go',EbN0,ber31,'-bo')
title('�����������ZF����㷨����')
legend('��1��','��2��', '��3��', '��4��')
xlabel('�����Eb/N0')
ylabel('������ʣ�BER��')

figure
semilogy(EbN0,ber24,'-ko',EbN0,ber23,'-ro',EbN0,ber22,'-go',EbN0,ber21,'-bo')
title('�������������ZF����㷨����')
legend('��1��','��2��', '��3��', '��4��')
xlabel('�����Eb/N0')
ylabel('������ʣ�BER��')

            