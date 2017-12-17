function J = normalize(I)
J = (I - min(I(:)))*(255-0)/(max(I(:))-min(I(:))) + 0;
end