fid = fopen('Outputs.txt', 'w');
fprintf(fid, 'The amount of times that the boats came within 54 meters of eachother was %3f times.', k);
fclose(fid);

k = 0;
d = 0;
dist = [];
while k < numel(time)
    [mApart] = distance(lat1, lat2, lon1, lon2);
    dist = [dist mApart];
    if dist(k) > 54
        if mApart <= 54
            d = 1+d;
        end
    end
    k = k + 1;
end
fprintf('The amount of times that the boats came within 54 meters of eachother was %3f times. \n', k)