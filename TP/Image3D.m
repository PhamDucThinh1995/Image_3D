clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%https://www.mathworks.com/help/images/ref/phantom.html#:~:text=P%20%3D%20phantom(%20E%20%2C%20n%20)%20generates%20a%20user%2D,used%20to%20generate%20the%20phantom.
P = phantom('Modified Shepp-Logan',258);   
figure;
imshow(P);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%https://www.mathworks.com/help/images/ref/radon.html
%https://en.wikipedia.org/wiki/Sinogram
% iptsetpref('ImshowAxesVisible','on')
% I = zeros(100,100);
% I(25:75, 25:75) = 1;
% theta = 0:179;
% [R,xp] = radon(I,theta);
% imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
% xlabel('\theta (degrees)')
% ylabel('x''')
% colormap(gca,hot), colorbar
% iptsetpref('ImshowAxesVisible','off')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Po Write%%%%%%%%%%%%%%%%%%%%%%%%
iptsetpref('ImshowAxesVisible','on')
theta = 0:179;
[R,xp] = radon(P,theta);
figure(1);
imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('x''')
title('Sinogram of Radon Transform')
iptsetpref('ImshowAxesVisible','off')
output_size = max(size(P));
I1=iradon(R,theta,output_size);
figure(2);
montage({I1},'Size',[1 1]);
title(['Reconstruction from Parallel Beam Projection ' ...
    'with 180 Projection Angles']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Prof Write%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reconstruct
% Constrain the output size of each reconstruction to be 
% the same as the size of the original image, |P|.
theta = 0:179; % là 180 samples v?i góc alpha là 1 ??
[RT,XT] = radon(P,theta);
figure(3);
imshow(RT,[]);
% Reconstruct
% Constrain the output size of each reconstruction to be 
% the same as the size of the original image, |P|.
output_size = max(size(P));
I1=iradon(RT,theta,output_size);
figure(4)
montage({I1},'Size',[1 1])
title(['Reconstruction from Parallel Beam Projection ' ...
    'with 180 Projection Angles'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta3 = 0:0.5:179.5;
[RT3,XT3] = radon(P,theta3);
figure(5);
imshow(RT3,[]);
recon03 = iradon(RT3,theta3);
figure(6);
imshow(recon03,[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%D%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta4 = 0:29;
[RT4,XT4] = radon(P,theta4);
figure(7);
imshow(RT4,[]);
recon04 = iradon(RT4,theta4);
figure(8);
imshow(recon04,[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%E%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta5 = 0:5:145;
[RT5,XT5] = radon(P,theta5);
figure(9);
imshow(RT5,[]);
recon05 = iradon(RT5,theta5);
figure(10);
imshow(recon05,[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%F + E%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[R,xp] = radon(P,theta);
R_bruit = imnoise(R,'gaussian');
Ir_=iradon(R_bruit,theta);
figure(11)
imshow(Ir_,[]);
theta = 0:179; % là 180 samples v?i góc alpha là 1 ??
[RT,XT] = radon(P,theta);
RT_bruit = imnoise(RT,'gaussian');
Ir_1=iradon(R_bruit,theta);
figure(12)
imshow(Ir_1,[]);
theta3 = 0:0.5:179.5;
[RT3,XT3] = radon(P,theta3);
RT3_bruit = imnoise(RT3,'gaussian');
Ir_3=iradon(RT3_bruit,theta3);
figure(13)
imshow(Ir_3,[]);
theta4 = 0:29;
[RT4,XT4] = radon(P,theta4);
RT4_bruit = imnoise(RT4,'gaussian');
Ir_4=iradon(RT4_bruit,theta4);
figure(14)
imshow(Ir_4,[]);
RT5_bruit = imnoise(RT5,'gaussian');
theta5 = 0:5:145;
[RT5,XT5] = radon(P,theta5);
Ir_5=iradon(RT5_bruit,theta5);
figure(15)
imshow(Ir_5,[]);

%%%%Professor
A = phantom(); theta180=0:179;
[RT,XT] = radon(A,theta180);
minRT=min(min(RT));
maxRT=max(max(RT));
figure(1);imshow(RT,[minRT-10,maxRT+10]);
RT_noise01=imnoise(RT,'gaussian');
figure(2); imshow(RT_noise01,[minRT-10,maxRT+10]);
RT_noise02=imnoise(RT,'gaussian',0,0.1);
figure(3); imshow(RT_noise02,[minRT-10,maxRT+10]);
RT_noise03=imnoise(RT,'gaussian',0,1);
figure(4); imshow(RT_noise03,[minRT-10,maxRT+10]);
A_noise = iradon(RT_noise02,theta180);
figure;imshow(A_noise,[]);
figure(1); imshow(A,[])
RT_noise02=imnoise(RT,'gaussian',0,10);
A_noise = iradon(RT_noise02,theta180);
imshow(A_noise,[])
figure(1); imshow(A,[])
RT_noise02=imnoise(RT,'gaussian',0,5);
A_noise = iradon(RT_noise02,theta180);
imshow(A_noise,[]);
figure(2); imshow(A_noise,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% min(min(A));max(max(A));
% figure(1);subplot(1,2,1);imshow(A,[]);
% subplot(1,2,2);imshow(A_noise,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RT_noise02=imnoise(RT,'gaussian',0,0.1);
[A_noise,filt01]=iradon(RT_noise02,theta180);
figure(1);figure(2);
plot(filt01)
[A_noise02,filt02]=iradon(RT_noise02,theta180,'Spline','Hamming');
figure(1);subplot(1,2,1);imshow(A_noise,[]);
subplot(1,2,2);imshow(A_noise02,[]);
figure(2);subplot(1,2,1);plot(filt01);subplot(1,2,2);plot(filt02);
imshow(A_noise02,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%G%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A02=iradon(RT,theta180,'Spline','Hamming');
A03=iradon(RT,theta180,'Spline','Shepp-Logan');
A04=iradon(RT,theta180,'Spline','Cosine');
%Plot the image after filter
figure(3);subplot(1,4,1);imshow(A,[]); % Phantom original
subplot(1,4,2);imshow(A02,[]);
subplot(1,4,3);imshow(A03,[]);
subplot(1,4,4);imshow(A04,[]);

[A_noise02,filt02]=iradon(RT_noise02,theta180,'Spline','Hamming');
[A_noise03,filt03]=iradon(RT_noise02,theta180,'Spline','Shepp-Logan');
[A_noise04,filt04]=iradon(RT_noise02,theta180,'Spline','Cosine');
[A_noise05,filt05]=iradon(RT_noise02,theta180,'Spline','Ram-Lak');
figure(2);%subplot(1,3,3);plot(filt04);
%subplot(1,3,1);plot(filt01);
%Plot the figure of filter
subplot(4,1,1);plot(filt01); %Original noise
subplot(4,1,2);plot(filt02); %Noise passed filter
subplot(4,1,3);plot(filt03);
subplot(4,1,4);plot(filt04);
figure(4);plot(filt05);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%H%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);figure(1);subplot(2,2,1);
imshow(A,[]);subplot(2,2,2);imshow(A_noise01,[]);
imshow(A_noise02,[]);subplot(2,2,3);imshow(A_noise04,[]);
subplot(2,2,4);imshow(A_noise05,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%I%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = phantom(); theta180 = 0:179;
figure(1);
subplot(1,2,1);
imshow(A,[]);
[RT,XT]=radon(A,theta180);
RT_noise02=imnoise(RT,'gaussian');
[A_noise,filt] = iradon(RT_noise02, theta180,'Spline','Hamming');
subplot(1,2,2);
imshow(A_noise,[]);

