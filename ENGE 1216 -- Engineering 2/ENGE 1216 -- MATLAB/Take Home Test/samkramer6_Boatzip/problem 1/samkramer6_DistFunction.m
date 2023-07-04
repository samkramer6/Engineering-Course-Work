function[dist] = distance(lat, lon, lastLon, lastLat)
        lat1R = (lat(1)*pi)/180;%This converts the readings into radians
        lat2R = (lastLat*pi)/180;
        lon1R = (lon(1)*pi)/180;
        lon2R = (lastLon*pi)/180;
        DlatR = lat2R - lat1R;
        DlonR = lon2R - lon1R;
            R = 6371000; %must be in meters to compute the distance between the boats in meters
            a = (sin(DlatR/2)).^2 + cos(lat1R).*cos(lat2R).*(sin(DlonR/2)).^2;
            c = 2*atan2(sqrt(a),sqrt(1-a));
            dist = (R*c);%find the distance
end
