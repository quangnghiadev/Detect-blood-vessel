function [ Dice ] = DicePercentMeasurement( truth_img, img )
%DICEPERCENTMEASUREMENT Summary of this function goes here
%   Detailed explanation goes here

    P = find(truth_img == 1 & img == 1);
    P1 = find(truth_img == 1);
    P2= find(img == 1);
    
    common = size(P,1);
    cm = size(P1,1);
    co = size(P2,1);
    Dice = (2*common)/(cm+co);
end

