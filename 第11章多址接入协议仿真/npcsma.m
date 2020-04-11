%np-CSMAЭ�����????? 
function [Traffic,S,Delay]=aloha(capture) 
%ALOHA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%   �������
%   capture:�Ƿ��ǲ���ЧӦ 0�������� 1������

%   �������
%   Traffic��ʵ�ʲ�����ҵ����
%   S��������
%   Dela��ƽ���ӳ�

 
%�����ն�״̬�����Լ�����������
STANDBY = 0; %�ȴ�                                 
TRANSMIT = 1; %����
COLLISION = 2; %��ײ      
TOTAL=10000; %�ɹ�����������ݰ���������   
 
% �����ŵ�����
brate = 6e6; %��������                       
Srate = 0.25e6; %��������                        
Plen = 500; %��������������                              
Ttime = Plen / Srate; %ÿ�����ݰ��Ĵ���ʱ��                         
Dtime = 0.1; %��һ������ʱ��   
delay = Dtime * Ttime;
alfa  = 3; %·�����ָ��                                    
sigma = 6; %��Ӱ˥���׼��[dB] 
 
%����������Ϣ
r = 100; %��������뾶                                 
bxy = [0, 0, 5]; %�����λ������ (x,y,z)[m]                               
tcn = 10; %����������ȷ�źŽ���������ͷ��Ź���[dBm] 
 

 
Mnum  = 100;                                  
mcn   = 30;                                   
mpow  = 10^(mcn/10) * sqrt(r^2+bxy(3)^2)^alfa;   
h=0;                                           
mxy = [randsrc(2,Mnum,[-r:r]); randsrc(1,Mnum,[0:h])]; 
while 1 
    d=sqrt(sum(mxy(1:2,:).^2));                    
    [tmp,indx]=find(d>r); 
    if length(indx) == 0                                 
        break 
    end 
    mxy(:,indx)=[randsrc(2,length(indx),[-r:r]);mxy(3,indx)];  
end 
distance=sqrt(sum(((ones(Mnum,1)*bxy).'-mxy).^2)); 
mrnd = randn(1,Mnum);                           
 
% G=[0.1:0.1:1,2:10,20:20:40];                 ?? 
G=[0.1:0.1:1,2:10,20];    
for indx=1:length(G) 
 
    %��ʼ����ز���������Possion�ֲ�
    Tint  = -Ttime / log(1-G(indx)/Mnum); %���ݰ��������������ֵ    
    Rint  = Tint; %���ݰ��ش����������ֵ                             
    Spnum = 0; %�ɹ�����İ�����                               
    Splen = 0; %�ɹ�����ķ��Ÿ���                             
    Tplen = 0; %������ķ�����                               
    Wtime = 0; %�����ӳ�ʱ��[z]                              
     
    mgtime        = -Tint * log(1-rand(1,Mnum));  
    Mstime        = zeros(1,Mnum) - inf;            
    mtime         = mgtime;                         
    Mstate        = zeros(1,Mnum);                  
    Mplen(1:Mnum) = Plen;                          
    now_time     = min(mtime);    
 
  
    while 1 
         
        idx = find(mtime==now_time & Mstate==TRANSMIT);   
         
        if length(idx) > 0 
            Spnum       = Spnum + 1; 
            Splen       = Splen + Mplen(idx); 
            Wtime       = Wtime + now_time - mgtime(idx); 
            Mstate(idx) = STANDBY; 
            mgtime(idx) = now_time - Tint * log(1-rand);   
            mtime(idx)  = mgtime(idx);                      
        end 
         
        idx = find(mtime==now_time & Mstate==COLLISION);    
        if length(idx) > 0 
            Mstate(idx) = STANDBY; 
            mtime(idx)  = now_time - Rint * log(1-rand(1,length(idx))); 
        end 
    
       idx = find(mtime==now_time & Mstate==STANDBY);                        
       if length(idx) > 0 
        Tplen = Tplen + sum(Mplen(idx)); 
            for ii=1:length(idx) 
                jj = idx(ii); 
               
                idx1 = find((Mstime+delay)<=now_time & now_time<=(Mstime+delay+Ttime));  
                if length(idx1) == 0                      
                    Mstate(jj) = TRANSMIT;                   
                    Mstime(jj) = now_time;                      
                    mtime(jj)  = now_time + Mplen(jj) / Srate;
                else                                            
                    mtime(jj) = now_time - Rint * log(1-rand); 
                end 
            end 
        end 
         
        if Spnum >= TOTAL                              
            break 
        end 
         
        idx = find(Mstate==TRANSMIT | Mstate==COLLISION);   
        if capture == 0                                  
            if length(idx) > 1 
                Mstate(idx) = COLLISION;                  
            end 
        else                                            
            if length(idx) > 1 
                dxy  = distance(idx);                      
                pow  = mpow * dxy.^-alfa .* 10.^(sigma/10*mrnd(idx));   
                [maxp no] = max(pow); 
                if Mstate(idx(no)) == TRANSMIT 
                    if length(idx) == 1 
                        cn = 10 * log10(maxp); 
                    else 
                        cn = 10 * log10(maxp/(sum(pow)-maxp+1)); 
                    end 
                    Mstate(idx) = COLLISION; 
                    if cn >= tcn                         
                        Mstate(idx(no)) = TRANSMIT;        
                    end 
                else 
                    Mstate(idx) = COLLISION; 
                end 
            end 
        end 
        now_time = min(mtime);                          
    end 
     
    Traffic(indx) = Tplen / Srate / now_time; %����ʵ�ʲ�����ҵ����    
    T=Traffic(indx) 
    S(indx) = Splen/Srate/now_time; %����������   
    Delay(indx) = Wtime / TOTAL * Srate / Plen; %����ƽ���ӳ�           
 
end 
 
%end


