clear all
N = 10000; %���͵�֡��
L = 16; %һ֡�е���Ϣ������
poly = [1 1 1 0 1 0 1 0 1]; %CRC���ɶ���ʽ
N1 = length(poly)-1; %CRC��ĳ���
EbN0 = 0:2:10;
ber = berawgn(EbN0,'qam',16);

for index=1:length(ber)
    index
    pe = ber(index) %BSC�ŵ��������
    err = zeros(1,N); %�����֡�Ƿ��������
    err1 = zeros(1,N); %ͨ��CRCУ�鴫���֡�Ƿ��������
    for iter=1:N
        msg = randi([0,1],1,L); %��Ϣ����
        msg1 = [msg zeros(1,N1)]; %��Ϣ��������
        [q,r] = deconv(msg1,poly); %�ö���ʽ������CRCУ�飬qΪ�̣�rΪ����
        r = mod(abs(r),2); %����ģ2����
        crc = r(L+1:end); %CRCУ����
        frame = [msg crc]; %����֡
        x = bsc(frame,pe); %ͨ��BSC�ŵ�
        [q1,r1] = deconv(x,poly); %�������г��Զ���ʽ
        r1 = mod(abs(r1),2); %ģ2����
        err(iter)=biterr(frame,x); %ͳ�Ʊ�֡�Ƿ��������
        err1(iter)=sum(r1); %ͨ��CRCͳ���Ƿ��������
    end
    fer1(index)=sum(err~=0); %��֡��
    fer2(index)=sum(err1~=0); %ͨ��CRCͳ����֡��
end

pnissed=(fer1-fer2)/N; %CRC©��ĸ���
semilogy(EbN0,pnissed)
title("CRC-8�������")
xlabel("Eb/N0");ylabel("©�����");
    