clear all
fd = 10; %������Ƶ��Ϊ10
ts = 1/1000;
t = 0:ts:1;
h1 = reyleigh(fd,t);

fd = 20; %������Ƶ��Ϊ20
h2 = reyleigh(fd,t);

subplot(2,1,1);plot(20*log10(abs(h1(1:1000))))
title("fd = 10Hz�ǵ��ŵ�����������")
xlabel("ʱ��");ylabel("����")

subplot(2,1,2);plot(20*log10(abs(h2(1:1000))))
title("fd = 20Hz�ǵ��ŵ�����������")
xlabel("ʱ��");ylabel("����")

