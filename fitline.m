function [ fit_coeffs ] = fitline( amp,switchingtime )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[BL,statsL]=robustfit(amp,switchingtime);
fit_coeffs = BL;

end

