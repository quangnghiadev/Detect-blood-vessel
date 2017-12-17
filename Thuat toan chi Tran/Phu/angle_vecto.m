function theta = angle_vecto(u,v)
CosTheta = dot(u,v)/(norm(u)*norm(v));
theta = acos(CosTheta)*180/pi;
end