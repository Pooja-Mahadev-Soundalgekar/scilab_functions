//
//Implementation of Matlab function bersync() in Scilab.
//
//Name:Pooja Mahadev Soundalgekar
//2nd Year Information Technology
//National Institute of Technology Karnataka
//Email: pooja27ms@gmail.com
//
//Function:bersync()
//
//Function argument types:
//
//1.ber = bersync(EbNo,timerr,'timing') 
//Example 1
//Input arguments:
//EbNo = [4 8] 
//timerr = 0.2 
//ber = bersync(EbNo,timerr,'timing') 
//Output arguments:
//ber =   0.0520727    0.0205365 
//Example 2
//Input arguments:
//EbNo = [8 12]
//timerr = 0.07
//ber = bersync(EbNo,timerr,'timing')
//Output arguments:
//ber = 0.0007976    0.0000049  
//
//2.ber = bersync(EbNo,phaserr,'carrier')
//Example 1
//Input arguments:
//EbNo = [4 5]
//phaserr= 0.1
//ber = bersync(EbNo,phaserr,'carrier')
//Output arguments:
//ber = 0.0128766    0.0061761  
//Example 2
//Input arguments:
//EbNo = [4 5]
//phaserr= 0.7
//ber = bersync(EbNo,phaserr,'carrier')
//Output arguments:
//ber =  0.0716198    0.0594576 
//
//Note: For timerr and carrier equal to zero, The equation is getting divided by 0 so an error message is displayed.
//Note: To evaluate the integral for limits infinity, we change the variable of integration from 
//x=(-inf,inf) to z=atan(x),x=tan(z),dx/dz = 1/(cos(z))^2
//In the new variable z, the integration limits are from -10^16 to +10^16 since this is considered as infinity in scilab and
//integral f(x)dx = integral f(x(z))*d(x(z))
//= integral f(z)*dx/dz*dz 
//This has been implemented by the modified functions.
//Resources:
//For the documentation of compand(): http://in.mathworks.com/help/comm/functionlist.html
//For understanding the syntax of Scilab, Scilab functions: http://spoken-tutorial.org/tutorial-search/?search_foss=Scilab&search_language=English
//

//Function definition:

//g(x)=exp(-x^2/2)
function[y]=g(x)
    y=exp(-1*x*x/2)
endfunction

function[y]=gmodified(z)
    x=tan(z)
    y=g(x)/(cos(z)^2)
endfunction

//f(x)=exp(-(xi^2)/(2*sigma^2))* (integral(g(x)) from (sqrt(2*R)*(1-2*|xi|)) to +infinity)
function[y]=f(xi,sigma,R)
    y=exp(-1 * xi * xi/(2*sigma*sigma))
    l=sqrt(2*R)*(1-2*abs(xi))
    y=y*intg(atan(l),atan(1.633*10^16),gmodified) // calculates integral of g(x) from l to +infinity
endfunction

function[y]=fmodified(z,sigma,R)
    x=tan(z)
    y=f(x,sigma,R)/(cos(z)^2)
endfunction

//f2(x)=exp(-(xi^2)/(2*sigma^2))* (integral(g(x)) from (sqrt(2*R)*(cos(xi)) to +infinity)
function[y]=f2(xi,sigma,R)
    y=exp(-1 * xi * xi/(2*sigma*sigma))
    l=sqrt(2*R)*cos(xi)
    y=y*intg(atan(l),atan(1.633*10^16),gmodified) // calculates integral of g(x) from l to +infinity
endfunction


function[y]=f2modified(z,sigma,R)
    x=tan(z)
    y=f2(x,sigma,R)/(cos(z)^2)
endfunction

function[y]= bersync(Ebno,timerr,opt)
    j=1
    for i = Ebno //loop through all the Ebnos
        i=10.^(i/10) //convert Ebno in decibel to linear 
        if(opt == "timing") then
            if(timerr==0)
                error("Timerr cannot be Zero.") //handle error for timerr=0 case
                y=0
                continue
            end
            temp=1/(4*%pi*timerr)
            temp = temp * intg(-atan(1.633*10^16),atan(1.633*10^16),list(fmodified,timerr,i))   // calculates integral of f from -infinity to +infinity
            temp2 = 1/(2*sqrt(2*%pi))
            temp2 = temp2 * intg(atan(sqrt(2*i)),atan(1.633*10^16),gmodified) // calculates integral of g from sqrt(2*i) to +infinity
            temp=temp+temp2
            y(1,j)=temp // append to y
        elseif(opt == "carrier") then
            if(timerr==0)
                error("Carrier cannot be Zero.") //handle error for carrier=0 case
                y=0
                continue
            end
            temp=1/(%pi*timerr)
            temp = temp * intg(0,atan(1.633*10^16),list(f2modified,timerr,i))  // calculates integral of f2 from 0 to +infinity
            y(1,j)=temp // append to y
        end
        j=j+1
    end
endfunction
