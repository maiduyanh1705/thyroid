% The function was written by Jianning Chi to implement the DCT image
% restoration for the artifacts removal.

function I2 = DCT_RES(I)
% Compute the two-dimensional DCT of 8-by-8 blocks in the image. The 
% function dctmtx returns the N-by-N DCT transform matrix.
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
% Discard all but 10 of the 64 DCT coefficients in each block.
mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);

%Reconstruct the image using the two-dimensional inverse DCT of each block.
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);
