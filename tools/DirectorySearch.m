function [imageset, val] = DirectorySearch( x, count, imageset )
    dirlist = dir(x);
    dirlist = dirlist(3:end, :);
    for i = 1:numel(dirlist);
        if(~contains(dirlist(i).name, 'txt'))
            imagepath = strcat(strcat(dirlist(i).folder, '\'), dirlist(i).name);
            imageset{count} = imagepath;
            count = count + 1;
        end
    end       
    val =  count
    
end

