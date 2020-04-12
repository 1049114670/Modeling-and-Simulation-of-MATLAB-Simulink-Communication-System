%����V-BLAST�ṹMMSE����㷨���ܣ����Ʒ�ʽΪQPSK
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
    x1 = [];
    x2 = [];
    x3 = [];
    for index1 = 1:L
        h = randn(Nt,Nr)+j*randn(Nt,Nr); %Rayleigh˥���ŵ�
        h = h./sqrt(2); %�ŵ�ϵ����һ��
        
        sigma1 = sqrt(1/(10.^(EbN0(index)/10))); %ÿ���������ߵĸ�˹��������׼��
        n = sigma1*(randn(N,Nr)+j*randn(N,Nr)); %ÿ���������ߵĸ�˹������
        w = h'*inv(h*h'+2*sigma1.^2*diag(ones(1,Nt))); %w�����Ž�
        
        y = s((index1-1)*N+1:index1*N,:)*h+n; %�ź�ͨ���ŵ�
        
        yy = y;
        y1 =  y*w; %�޸�������ʱ��MMSE���
        temp1 = pskdemod(y1,M,pi/4); %�޸�������ʱ�Ľ��
        x1 = [x1;temp1]; %�޸�������ʱ�Ľ�����
        
        temp2(:,Nt) = temp1(:,Nt);
        y = y-pskmod(temp2(:,Nt),4,pi/4)*h(Nt,:); %�������������ʱ�������źž���ĸ���
        
        temp3(:,Nt) = temp1(:,Nt);
        yy = yy-s((index1-1)*N+1:index1*N,Nt)*h(Nt,:); %�����������ʱ�������źž���ĸ���
        
        h = h(1:Nt-1,:)
        
        for ii=Nt-1:-1:1
            w = h'*inv(h*h'++2*sigma1.^2*diag(ones(1,ii))); %�ŵ�������º��w
            
            y1 = y*w; %��������������ļ������
            temp2(:,ii)=pskdemod(y1(:,ii),M,pi/4);
            y = y-pskmod(temp2(:,ii),4,pi/4)*h(ii,:);
            
            yy1 = yy*w; %������������ļ������
            temp3(:,ii)=pskdemod(yy1(:,ii),M,pi/4);
            yy = yy-s((index1-1)*N+1:index1*N,ii)*h(ii,:);
            
            h = h(1:ii-1,:);
        end
        x2 = [x2;temp2]; %�������������ʱ�Ľ��
        x3 = [x3;temp3]; %�����������ʱ�Ľ��   
    end
    
    [temp,ber1(index)] = biterr(x,x1,log2(M)); %�޸�������ʱ��ϵͳ����
    [temp,ber2(index)] = biterr(x,x2,log2(M)); %�������������ʱ��ϵͳ����
    [temp,ber3(index)] = biterr(x,x3,log2(M)); %�����������ʱ��ϵͳ����
    
    [temp,ber24(index)] = biterr(x(:,1),x2(:,1),log2(M)); %�������������ʱ��4���ϵͳ����
    [temp,ber23(index)] = biterr(x(:,2),x2(:,2),log2(M)); %�������������ʱ��3���ϵͳ����
    [temp,ber22(index)] = biterr(x(:,3),x2(:,3),log2(M)); %�������������ʱ��2���ϵͳ����
    [temp,ber21(index)] = biterr(x(:,4),x2(:,4),log2(M)); %�������������ʱ��1���ϵͳ����
    
    [temp,ber34(index)] = biterr(x(:,1),x3(:,1),log2(M)); %�����������ʱ��4���ϵͳ����
    [temp,ber33(index)] = biterr(x(:,2),x3(:,2),log2(M)); %�����������ʱ��3���ϵͳ����
    [temp,ber32(index)] = biterr(x(:,3),x3(:,3),log2(M)); %�����������ʱ��2���ϵͳ����
    [temp,ber31(index)] = biterr(x(:,4),x3(:,4),log2(M)); %�����������ʱ��1���ϵͳ����
    
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

            