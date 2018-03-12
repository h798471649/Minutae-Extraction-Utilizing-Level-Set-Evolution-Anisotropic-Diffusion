function image = ContrastEnhancement(image, param)
if(strcmp(param,'hist')==1)
    % perform adpative histogram equalization
    image = adapthisteq(image, 'Distribution', 'uniform','clipLimit', 0.05,'NumTiles', [5 5]);  
end


end

