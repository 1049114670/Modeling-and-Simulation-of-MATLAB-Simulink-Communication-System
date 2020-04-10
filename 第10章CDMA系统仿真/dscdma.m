%ֱ��������Ƶ���������
function [ber] = dscdma(user,seq)
%DSCDMA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   user:ͬʱ������Ƶͨ�ŵ��û���
%   seq����Ƶ��1��m-����  ��Ƶ��2��Gold-����  ��Ƶ��3������Gold-����
%   ber�����û����µ�������

%��ʼ��
sr = 256000.0; %��������
nSymbol = 10000; %ÿ��������·��͵ķ�����
M = 4; %4-QAM����
br = sr*log2(M); %��������
graycode = [0 1 3 2]; %Gray�������
EbNo = 0:2:10; %Eb/N0�仯��Χ

%%%��������˲�������%%%
delay = 10; %�������˲���ʱ��
Fs = 8; %�˲�����������
rolloff = 0.5; %�������˲�����������
rrcfilter = rcosine(1,Fs,'fir/sqrt',rolloff,delay); %��Ƹ��������˲���

%%%��Ƶ���������%%%
user = 4; %�û���
stage = 3; %m���еĽ���
ptap1 = [1 3]; %m����1�ļĴ������ӷ�ʽ
ptap2 = [2 3]; %m����2�ļĴ������ӷ�ʽ
regi1 = [1 1 1]; %m����1�ļĴ�����ʼֵ
regi2 = [1 1 1]; %m����1�ļĴ�����ʼֵ

%%%��Ƶ�������%%%
switch seq
case 1 %M����
    code = mseq(stage,ptap1,regi1,user);
case 2
    m1 = mseq(stage,ptap1,regi1); %Gold����
    m2 = mseq(stage,ptap2,regi2);
    code = goldseq(m1,m2,user);
case 3
    m1 = mseq(stage,ptap1,regi1); %����Gold����
    m2 = mseq(stage,ptap2,regi2);
    code = [goldseq(m1,m2,user),zeros(user,1)];
end
code = code*2-1;
clen = length(code);

%%%˥���ŵ�����%%%
ts = 1/Fs/sr/clen; %����ʱ����
t = (0:nSymbol*Fs*clen-1+2*delay*Fs)*ts; %ÿ��������µķ��Ŵ���ʱ��
% fd=160; %������Ƶ��[HZ]
% h=rayleigh(fd,t); %����˥���ŵ�

%%%���濪ʼ%%
for indx=1:length(EbNo)

%�����
data = randsrc(user,nSymbol,0:3); %���������û��ķ�������
data1 = graycode(data+1); %Gray����
data1 = qammod(data1,M); %4-QAM����
[out] = spread(data1,code); %��Ƶ

out1 = rcosflt(out.',sr,Fs*sr,'filter',rrcfilter); %ͨ����������˲���
spow = sum(abs((out1)).^2)/nSymbol; %����ÿ���û��źŹ���
if user>1
    out1 = sum(out1.'); %�û�������1�������û��������
else 
    out1 = out1.';
end

%%%ͨ������˥���ŵ�%%
% out1=h.*out1;
%���ն�
sigma = sqrt(0.5*spow*sr/br*10^(-EbNo(indx)/10)); %��������ȼ����˹����������
y = [];
for ii=1:user
y(ii,:) = out1+sigma(ii).*(randn(1,length(out1))+j*randn(1,length(out1))); %�����˹��������AWGN��
% y(ii,:)=y(ii,:)./h; %���������ŵ�����
end

y = rcosflt(y.',sr,Fs*sr,'Fs/filter',rrcfilter); %ͨ����������˲����˲�
y = downsample(y,Fs); %������
for ii=1:user
    y1(:,ii)=y(2*delay+1:end-2*delay,ii);
end

yd = despread(y1.',code); %���ݽ���
demodata = qamdemod(yd,M); %4-QAM���
demodata = graycode(demodata+1); %Gray������ӳ��

[err,ber(indx)] = biterr(data(1,:),demodata(1,:),log2(M));
end


