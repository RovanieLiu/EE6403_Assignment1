% written by Yuxing Liu 14/2/2023
% Happy Valentinue's Day! /flower
clc;clear;
% One of my favourite actors :) very handsome
img = imread('JamesMcAvoy.jpg');

%% Method 2: employ SVD in R/G/B channel seperately and reconstruct
k = 50;
Rk=reconstruct_img(k,img);
Rk01=reconstruct_img(k*0.1,img);
Rk05=reconstruct_img(k*0.5,img);
Rk2=reconstruct_img(k*2,img);
Rk3=reconstruct_img(k*3,img);

% plot
figure(1);

subplot(3,2,1);
imshow(img);
title('Original RGB Image');
subplot(3,2,3);
imshow(Rk01);
title(['Reconstructed Image Rank=',num2str(k*0.1)]);
subplot(3,2,5);
imshow(Rk05);
title(['Reconstructed Image Rank=',num2str(k*0.5)]);

% compare

subplot(3,2,2);
imshow(Rk);
title(['Reconstructed Image Rank=',num2str(k)]);
subplot(3,2,4);
imshow(Rk2);
title(['Reconstructed Image Rank=',num2str(k*2)]);
subplot(3,2,6);
imshow(Rk3);
title(['Reconstructed Image Rank=',num2str(k*3)]);

function [Rimg]=reconstruct_img(k,img)
    h = size(img,1);
    w = size(img,2);
    
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    Rd = im2double(R);
    Gd = im2double(G);
    Bd = im2double(B);
    
    [Ur,Sr,Vr] = svd(Rd);
    [Ug,Sg,Vg] = svd(Gd);
    [Ub,Sb,Vb] = svd(Bd);
    
    Rt = zeros(h,w);
    Gt = zeros(h,w);
    Bt = zeros(h,w);
    for i = 1:k
        Rt = Rt + Sr(i,i)*Ur(:,i)*Vr(:,i)';
        Gt = Gt + Sg(i,i)*Ug(:,i)*Vg(:,i)';
        Bt = Bt + Sb(i,i)*Ub(:,i)*Vb(:,i)';
    end
    Rimg(:,:,1) = im2uint8(Rt);
    Rimg(:,:,2) = im2uint8(Gt);
    Rimg(:,:,3) = im2uint8(Bt);
end 