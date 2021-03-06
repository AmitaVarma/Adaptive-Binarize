using Images
function adaptive_threshold(img::Array,s::Integer=Int(2*floor(size(img)[1]/16 + 1)),t::Integer=15)
    if s%2!=0 || s<=0 
        error("Window size must be an even positive non-zero integer")
    end
    if s>size(img)[1] || s>size(img)[2]
        error("Window size must be smaller than length and width of image")
    end
    if t<0 || t>100
        error("Comparison % must be between 0 and 100")
    end
    
    w= size(img)[1]; # Width of image
    h= size(img)[2]; # Height of image
    
    intimg= zeros(size(img)) # Initialize the integral image
    img=Gray.(img);

    # For calculating integral image (pass 1)
    for i=1:w
        sum=0
        for j=1:h
            sum+=img[i,j]
            (i==0) ? intimg[i,j]=sum : intimg[i,j]+=sum
        end
    end
    intimg=Gray.(intimg/255); # To convert from 0-255 scale to 0-1 scale
    
    c=0; # Initialize count c
    opimg= zeros(size(img)) # Initialize the output image

    # For calculating window average on integral image and comparing pixel to average 
    for i=1:w, j=1:h

        # x1,x2,y1,y2 are corner pixels of window, along with border checking
        (i-s/2>1) ? x1= Int(i-s/2) : x1= 2
        (i+s/2<=w) ? x2= Int(i+s/2) : x2= w
        (j-s/2>1) ? y1= Int(j-s/2) : y1= 2
        (j+s/2<=h) ? y2= Int(j+s/2) : y2= h

        c=(x2-x1)*(y2-y1)
        c=c/255
        sum=intimg[x2,y2]-intimg[x2,y1-1]-intimg[x1-1,y2]+intimg[x1-1,y1-1]
        sum=sum/255
        (img[i,j]*c <= sum+(100-t)/100) ? opimg[i,j]=0 : opimg[i,j]=1

    end
    
    return Gray.(opimg)
end
