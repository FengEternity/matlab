
function res  = medsmooth(ima,smax,factors)

winsizes = floor(factors);
ind = find(factors> smax);
winsizes(ind)= smax;
[dimy,dimx,ncol] = size( ima);

res = ima;
for l=(1:ncol)
    for j=(1:dimy)
        for k = (1:dimx)
            imacrop= ima(max(1,floor(j-winsizes(j,k)/2)):min(dimy,floor(j+winsizes(j,k)/2)),...
                max(1,floor(k-winsizes(j,k)/2)):min(dimx,floor(k+winsizes(j,k)/2)),1);
        end
    end
end




