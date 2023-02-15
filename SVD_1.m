% written by Yuxing Liu 14/2/2023
% Happy Valentinue's Day! /flower
clc;clear;
% One of my favourite actors :) very handsome
img = imread('JamesMcAvoy.jpg');

%% Method 1: combine three channel into one gray
gray_img = rgb2gray(img);
[U,S,V] = svd(double(gray_img));

% reconstruct function declaration
% function [img, ratio]=reconstruct(gray_img,k,U,S,V)
%   input:
%       k-rank
%       U/S/V- the matrixs after function SVD of img
%   output:
%       img-reconstructed img under rank k
%       ratio-conpression ratio

k=50;
[rimg_25,r1]=reconstruct(gray_img,k/2,U,S,V);
[rimg_50,r2]=reconstruct(gray_img,k,U,S,V);
[rimg_100,r3]=reconstruct(gray_img,k*2,U,S,V);
[rimg_150,r4]=reconstruct(gray_img,k*3,U,S,V);

% plot
figure(1);

subplot(3,2,1);
imshow(img);
title('Original RGB Image');
subplot(3,2,3);
imshow(gray_img);
title('Tuned into Gray');
subplot(3,2,5);
imshow(rimg_50);
title(['Reconstructed Image Rank=',num2str(k)]);
xlabel(['Compression Ratio:',num2str(r2)]);

% compare

subplot(3,2,2);
imshow(rimg_25);
title(['Reconstructed Image Rank=',num2str(k/2)]);
xlabel(['Compression Ratio:',num2str(r1)]);
subplot(3,2,4);
imshow(rimg_100);
title(['Reconstructed Image Rank=',num2str(k*2)]);
xlabel(['Compression Ratio:',num2str(r3)]);
subplot(3,2,6);
imshow(rimg_150);
title(['Reconstructed Image Rank=',num2str(k*3)]);
xlabel(['Compression Ratio:',num2str(r4)]);


function [img, ratio]=reconstruct(gray_img,k,U,S,V)
    S_k = S(1:k, 1:k);
    img = U(:, 1:k) * S_k * V(:, 1:k)';
    ratio = numel(gray_img) / (numel(U(:, 1:k)) ...
        + numel(S_k) + numel(V(:, 1:k)));
end

