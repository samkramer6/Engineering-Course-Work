%This is the function that will compute the 
function[mApart] = distance(lat1, lat2, lon1, lon2)
    lat1R = (lat1.*pi)/180;%This converts the readings into radians
    lat2R = (lat2.*pi)/180;
    lon1R = (lon1.*pi)/180;
    lon2R = (lon2.*pi)/180;
    Dlat = lat2R - lat1R;
    Dlon = lon2R - lon1R;
        Rearth = 6371000; %must be in meters to compute the distance between the boats in meters
        c = (sin(Dlat/2)).^2 + cos(lat1R).*cos(lat2R).*(sin(Dlon/2)).^2;
        g = 2*atan2(sqrt(c),sqrt(1-c));
        mApart = Rearth*g;
end

