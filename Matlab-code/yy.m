 %if ~exist('output', 'dir')
%    mkdir('output');
%end
%if ~exist('upload', 'dir')
%    mkdir('upload');
%end
  while(1)
    %zhongjiang=[0,5,0,7,0,9,1,8,2,9,3,0,0,2];
     imageReadyFile = 'C:\wamp\www\upload\image_ready.jpg';
    while( ~exist(imageReadyFile, 'file'))
      
          pause(0.5);
         disp('Waiting for image-is-ready signal');
         continue;  
         end
       
  imageReadyFile = 'C:\wamp\www\cang\image_ready.jpg';
    p_ori=imread(imageReadyFile);
    figure(1);
    imshow(p_ori);
    
    thresh = graythresh(p_ori); 
    
    p_gray=rgb2gray(p_ori);
    %figure;
    %imshow(p_gray);
 
    p_edge=edge(p_gray,'Sobel',0.15,'both');
    %figure;
    %imshow(p_edge);
    
    %Car_Image_Perform=bwareaopen(Car_Image_Bin,250);
    %figure;
    %imshow(Car_Image_Perform);
    
    Se=[1;1;1];
    p_erode=imerode(p_edge,Se);
    %figure(10);
    %imshow(p_erode);
    
    Se=strel('rectangle',[75,75]);
    p_perform=imclose(p_erode,Se);
    %figure(8);
    %imshow(p_perform);
    
    p_last1=bwareaopen(p_perform,500);
    %figure(9);
    %imshow(p_last1);
    
    p_last2=bwareaopen(p_last1,15300);
    %figure(10);
    %imshow(p_last2);
    
    p_last3=p_last1-p_last2;
    %Car_Image_Perform=~Car_Image_Perform;
    %figure(11);
    %imshow(p_last3);
   % p_last3
   % Car_Image_Perform2=bwareaopen(Car_Image_Perform,50);
   % figure;
   % imshow(Car_Image_Perform2)
   
[y,x,z]=size(p_last3);
myI=double(p_last3);
    %begin����ɨ��
tic
     white_y=zeros(y,1);
      for i=1:y
         for j=1:x
             if(myI(i,j,1)==1) 
          %���myI(i,j,1)��myIͼ��������Ϊ(i,j)�ĵ�Ϊ��ɫ
          %��Blue_y����Ӧ�е�Ԫ��white_y(i,1)ֵ��1
           white_y(i,1)= white_y(i,1)+1;%��ɫ���ص�ͳ�� 
              end  
end       
 end
 [temp,MaxY]=max(white_y);%tempΪ����white_y��Ԫ���е����ֵ��MaxYΪ��ֵ�������� �������е�λ�ã�
 PY1=MaxY;
     while ((white_y(PY1,1)>=128)&&(PY1>1))   %��
          PY1=PY1-1;
 end    
 PY2=MaxY;
     while ((white_y(PY2,1)>=1)&&(PY2<y))   %��
        PY2=PY2+1;
     end
     I1=p_ori(PY1:PY2,:,:);
     I2=p_last3(PY1:PY2,:,:);
%IYΪԭʼͼ��I�н�ȡ����������PY1��PY2֮��Ĳ���
 %end����ɨ��
 %begin����ɨ��
   
        
      
 
 
 
    white_x=zeros(1,x);%��һ��ȷ��x����ĳ�������
 for i=1:(PY2-PY1)
         for j=1:x
             if(I2(i,j,1)==1)
                  white_x(1,j)= white_x(1,j)+1;               
               end  
           end       
 end
  %[temp2,MaxX]=max(white_x);
  for i=1:1:x
     if (white_x(1,i)>=1)
        PX1=i;
     end
  end

 for j=x:(-1):1
      if (white_x(1,j)>=1)
        PX2=j;
      end
 end
 
 
    
 
 
 
 %end����ɨ��
 %PX1=PX1-2;%�Գ��������У��
 %PX2=PX2+2;
 dw=I1(:,PX2:PX1,:);
        t=toc; 
%figure(7),subplot(1,2,2),imshow(dw),title('��λ���к�Ĳ�ɫͼ��')
figure(7);
imshow(dw);
imwrite(dw,'dw.jpg');

    for i=1:1:x
      if(white_x(1,i)>0)
         l1=i;
      break
      end 
    end
    
   for i=l1:1:x
      if(white_x(1,i)==0)
          r1=i;
      break
      end
   end
   
   r1=r1+5
   

  
  for i=r1:1:x
      if(white_x(1,i)>0)
         l2=i;
      break
      end 
  end
  
  for i=l2:1:x
      if(white_x(1,i)==0)
         r2=i;
      break
      end
  end
  
  cat=I1(:,l2:PX1,:);
  %figure(102);
  %imshow(cat);

  
  hehe1=rgb2gray(cat);
hehe2=im2bw(hehe1);

figure;
hehe2=~hehe2;
imshow(hehe2);


white_final=zeros(1,PX1-l2);
 for i=1:(PY2-PY1)
         for j=1:(PX1-l2)
             if(hehe2(i,j,1)==1)
                  white_final(1,j)= white_final(1,j)+1;               
               end  
           end       
 end

 
for i=1:1:(PX1-l2)
    if(white_final(1,i)==0)
        r3=i;
      break;
    end
end
%r3 �൱�ڵ�һ�����ֵ������ұ�
for i=r3:1:(PX1-l2)
    if(white_final(1,i)>0)
        l4=i;
      break;
    end
end
%l4�ǵڶ������ֵ�����ߣ����в����������֣����ǵ������֣�
for i=l4:1:(PX1-l2)
    if(white_final(1,i)==0)
        r4=i;
      break;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%


first=hehe2(:,1:(r4-1),:);
%figure(101);
%imshow(first);


%%%%%%%%%%%%%%%%%%%��һ�����¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r4-1)
             if(first(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 for i=(y1down+1):1:(PY2-PY1)
     if(white_final_y(i,1)>0)
        y2up=i;
      break;
    end
 end
 
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%��һ����
first_shang=first(1:y1down,:,:);
first_shang_1=first(1:y1down,1:(r3-1),:);
first_shang_2=first(1:y1down,l4:(r4-1),:);

shang=hehe2(1:y1down,:,:);
figure(101);
imshow(shang);

figure(4),subplot(2,6,1),imshow(first_shang),title ('��1')
figure(5),subplot(3,6,1),imshow(first_shang_1),title ('��1_1')
figure(5),subplot(3,6,2),imshow(first_shang_2),title ('��1_2')
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%��һ����
first_xia=first((y2up+1):(PY2-PY1),:,:);
first_xia_1=first((y2up+1):(PY2-PY1),1:(r3-1),:);
first_xia_2=first((y2up+1):(PY2-PY1),l4:(r4-1),:);

xia=hehe2((y2up+1):(PY2-PY1),:,:);
figure(102);
imshow(xia);
%figure;
%imshow(first_xia);
figure(4),subplot(2,6,7),imshow(first_xia),title ('��1')
figure(5),subplot(3,6,13),imshow(first_xia_1),title ('��1_1')
figure(5),subplot(3,6,14),imshow(first_xia_2),title ('��1_2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=r4:1:(PX1-l2)
    if(white_final(1,i)>0)
        l5=i;
      break;
    end
end
%r4�ǵڶ������ֵ����ұߣ����в����������֣����ǵ������֣�
for i=l5:1:(PX1-l2)
    if(white_final(1,i)==0)
        r5=i;
      break;
    end
end


%r3 �൱�ڵ�һ�����ֵ������ұ�
for i=r5:1:(PX1-l2)
    if(white_final(1,i)>0)
        l6=i;
      break;
    end
end
%l4�ǵڶ������ֵ�����ߣ����в����������֣����ǵ������֣�
for i=l6:1:(PX1-l2)
    if(white_final(1,i)==0)
        r6=i;
      break;
    end
end



%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
second=hehe2(1:(PY2-PY1),l5:r6,:);
%figure;
%imshow(second);

%%%%%%%%%%%%%%%%%%%�ڶ������¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r6-l5)
             if(second(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%�ڶ�����
second_shang=hehe2(1:y1down,l5:(r6-1),:);
second_shang_1=hehe2(1:y1down,l5:(r5-1),:);
second_shang_2=hehe2(1:y1down,l6:(r6-1),:);
%figure;
%imshow(second_shang);
figure(4),subplot(2,6,2),imshow(second_shang),title ('��2')
figure(5),subplot(3,6,3),imshow(second_shang_1),title ('��2_1')
figure(5),subplot(3,6,4),imshow(second_shang_2),title ('��2_2')

%%%%%%%%%%%%%%%%%%%%%���������
for i=r6:1:(PX1-l2)
    if(white_final(1,i)>0)
        l7=i;
      break;
    end
end

for i=l7:1:(PX1-l2)
    if(white_final(1,i)==0)
        r7=i;
      break;
    end
end


for i=r7:1:(PX1-l2)
    if(white_final(1,i)>0)
        l8=i;
      break;
    end
end

for i=l8:1:(PX1-l2)
    if(white_final(1,i)==0)
        r8=i;
      break;
    end
end


%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
third=hehe2(1:(PY2-PY1),l7:r8,:);
%figure;
%imshow(third);

%%%%%%%%%%%%%%%%%%%���������¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r8-l7)
             if(third(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%��������
third_shang=hehe2(1:y1down,l7:(r8-1),:);
third_shang_1=hehe2(1:y1down,l7:(r7-1),:);
third_shang_2=hehe2(1:y1down,l8:(r8-1),:);
%figure;
%imshow(third_shang);
figure(4),subplot(2,6,3),imshow(third_shang),title ('��3')
figure(5),subplot(3,6,5),imshow(third_shang_1),title ('��3_1')
figure(5),subplot(3,6,6),imshow(third_shang_2),title ('��3_2')



%%%%%%%%%%%%%%%%%%%%%������ĸ�
for i=r8:1:(PX1-l2)
    if(white_final(1,i)>0)
        l9=i;
      break;
    end
end

for i=l9:1:(PX1-l2)
    if(white_final(1,i)==0)
        r9=i;
      break;
    end
end


for i=r9:1:(PX1-l2)
    if(white_final(1,i)>0)
        l10=i;
      break;
    end
end

for i=l10:1:(PX1-l2)
    if(white_final(1,i)==0)
        r10=i;
      break;
    end
end


%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
fourth=hehe2(1:(PY2-PY1),l9:r10,:);
%figure;
%imshow(forth);

%%%%%%%%%%%%%%%%%%%���ĸ����¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r10-l9)
             if(fourth(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%���ĸ���
fourth_shang=hehe2(1:y1down,l9:(r10-1),:);
fourth_shang_1=hehe2(1:y1down,l9:(r9-1),:);
fourth_shang_2=hehe2(1:y1down-2,l10:(r10-1),:);
%figure;
%imshow(firth_shang);
figure(4),subplot(2,6,4),imshow(fourth_shang),title ('��4')
figure(5),subplot(3,6,7),imshow(fourth_shang_1),title ('��4_1')
figure(5),subplot(3,6,8),imshow(fourth_shang_2),title ('��4_2')




%%%%%%%%%%%%%%%%%%%%%��������
for i=r10:1:(PX1-l2)
    if(white_final(1,i)>0)
        l11=i;
      break;
    end
end

for i=l11:1:(PX1-l2)
    if(white_final(1,i)==0)
        r11=i;
      break;
    end
end


for i=r11:1:(PX1-l2)
    if(white_final(1,i)>0)
        l12=i;
      break;
    end
end

for i=l12:1:(PX1-l2)
    if(white_final(1,i)==0)
        r12=i;
      break;
    end
end


%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
fifth=hehe2(1:(PY2-PY1),l11:r12,:);
%figure;
%imshow(fifth);

%%%%%%%%%%%%%%%%%%%��������¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r12-l11)
             if(fifth(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%�������
fifth_shang=hehe2(1:y1down,l11:(r12-1),:);
fifth_shang_1=hehe2(1:y1down-2,l11:(r11-1),:);
fifth_shang_2=hehe2(1:y1down-2,l12:(r12-1),:);
%figure;
%imshow(firth_shang);
figure(4),subplot(2,6,5),imshow(fifth_shang),title ('��5')
figure(5),subplot(3,6,9),imshow(fifth_shang_1),title ('��5_1')
figure(5),subplot(3,6,10),imshow(fifth_shang_2),title ('��5_2')



%%%%%%%%%%%%%%%%%%%%%���������
for i=r12:1:(PX1-l2)
    if(white_final(1,i)>0)
        l13=i;
      break;
    end
end

for i=l13:1:(PX1-l2)
    if(white_final(1,i)==0)
        r13=i;
      break;
    end
end


for i=r13:1:(PX1-l2)
    if(white_final(1,i)>0)
        l14=i;
      break;
    end
end

for i=l14:1:(PX1-l2)
    if(white_final(1,i)==0)
        r14=i;
      break;
    end
end


%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
sixth=hehe2(1:(PY2-PY1),l13:r14,:);
%figure;
%imshow(sixth);

%%%%%%%%%%%%%%%%%%%���������¶Ժ���ͶӰ
white_final_y=zeros(PY2-PY1,1);
 for i=1:(PY2-PY1)
         for j=1:(r14-l13)
             if(sixth(i,j,1)==1)
                  white_final_y(i,1)= white_final_y(i,1)+1;               
               end  
           end       
 end

  %%%%%%%%%%%%%%%%�����г���������
 for i=1:1:(PY2-PY1)
     if(white_final_y(i,1)==0)
        y1down=i;
      break;
    end
 end
 y1down=y1down-1;
 
 
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%��������
sixth_shang=hehe2(1:y1down,l13:(r14-1),:);
sixth_shang_1=hehe2(1:y1down,l13:(r13-1),:);
sixth_shang_2=hehe2(1:y1down,l14:(r14-1),:);
%figure;
%imshow(sixth_shang);
figure(4),subplot(2,6,6),imshow(sixth_shang),title ('��6')
figure(5),subplot(3,6,11),imshow(sixth_shang_1),title ('��6_1')
figure(5),subplot(3,6,12),imshow(sixth_shang_2),title ('��6_2')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��һ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��
red_word1_1=imresize(first_shang_1,[40 20]);
red_word1_2=imresize(first_shang_2,[40 20]);
red_word2_1=imresize(second_shang_1,[40 20]);
red_word2_2=imresize(second_shang_2,[40 20]);
red_word3_1=imresize(third_shang_1,[40 20]);
red_word3_2=imresize(third_shang_2,[40 20]);
red_word4_1=imresize(fourth_shang_1,[40 20]);
red_word4_2=imresize(fourth_shang_2,[40 20]);
red_word5_1=imresize(fifth_shang_1,[40 20]);
red_word5_2=imresize(fifth_shang_2,[40 20]);
red_word6_1=imresize(sixth_shang_1,[40 20]);
red_word6_2=imresize(sixth_shang_2,[40 20]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��
blue_word1_1=imresize(first_xia_1,[40 20]);
blue_word1_2=imresize(first_xia_2,[40 20]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʾ��
figure(6),subplot(3,6,1),imshow(red_word1_1),title ('��1_1')
figure(6),subplot(3,6,2),imshow(red_word1_2),title ('��1_2')
figure(6),subplot(3,6,3),imshow(red_word2_1),title ('��2_1')
figure(6),subplot(3,6,4),imshow(red_word2_2),title ('��2_2')
figure(6),subplot(3,6,5),imshow(red_word3_1),title ('��3_1')
figure(6),subplot(3,6,6),imshow(red_word3_2),title ('��3_2')
figure(6),subplot(3,6,7),imshow(red_word4_1),title ('��4_1')
figure(6),subplot(3,6,8),imshow(red_word4_2),title ('��4_2')
figure(6),subplot(3,6,9),imshow(red_word5_1),title ('��5_1')
figure(6),subplot(3,6,10),imshow(red_word5_2),title ('��5_2')
figure(6),subplot(3,6,11),imshow(red_word6_1),title ('��6_1')
figure(6),subplot(3,6,12),imshow(red_word6_2),title ('��6_2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʾ��
figure(6),subplot(3,6,13),imshow(blue_word1_1),title ('��1_1')
figure(6),subplot(3,6,14),imshow(blue_word1_2),title ('��1_2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����1~14
imwrite(red_word1_1,'1.jpg');
imwrite(red_word1_2,'2.jpg');
imwrite(red_word2_1,'3.jpg');
imwrite(red_word2_2,'4.jpg');
imwrite(red_word3_1,'5.jpg');
imwrite(red_word3_2,'6.jpg');
imwrite(red_word4_1,'7.jpg');
imwrite(red_word4_2,'8.jpg');
imwrite(red_word5_1,'9.jpg');
imwrite(red_word5_2,'10.jpg');
imwrite(red_word6_1,'11.jpg');
imwrite(red_word6_2,'12.jpg');
imwrite(blue_word1_1,'13.jpg');
imwrite(blue_word1_2,'14.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ַ�ʶ��
SubBw2=zeros(40,20);
for I=1:14
    ii=int2str(I);
    t=imread([ii,'.jpg']);
    shibienum=imresize(t,[40 20],'nearest'); 
    for k2=0:9
        mm=int2str(k2)
        fname=strcat('C:\wamp\www\�ֿ�\',mm,'.jpg');
        kunum = imread(fname);
         for  i=1:40
                for j=1:20
                    SubBw2(i,j)=shibienum(i,j)-kunum(i,j);
                end
         end
    Dmax=1;
            for k1=1:40
                for l1=1:20
                    if  ( SubBw2(k1,l1) > 0 | SubBw2(k1,l1) <0 )
                        Dmax=Dmax+1;
                    end
                end
            end
            cha(k2+1)=Dmax;
    end
        wucha_all=cha(1:10);
        %minwucha=min(wucha_all);
        [temp,minwucha]=min(wucha_all);
        %findc=find(wucha_all==minwucha);
        findc(I)=minwucha-1;
end



%dog=dw(:,l6:r14,:);
%figure;
%imshow(dog);
%imwrite(dog,'dog.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%������ɣ�ɾ��ԭͼ
delete('C:\wamp\www\upload\image_ready.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������findc.txt

findc_string=int2str(findc);
save('C:\wamp\www\findc.txt','findc');

fid=fopen('C:\wamp\www\findc.txt','wt');
fprintf(fid,'%g',findc);
fclose(fid);


 continue;
  end
 