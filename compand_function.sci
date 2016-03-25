//
//Implementation of Matlab function compand() in Scilab.
//
//Name:Pooja Mahadev Soundalgekar
//2nd Year Information Technology
//National Institute of Technology Karnataka
//Email: pooja27ms@gmail.com
//
//Function:compand()
//
//Function argument types:
//
//1. out = compand(in,param,v) same behaviour as of out = compand(in,Mu,v,'mu/compressor')
//Input arguments:
//data = 2:2:12
//compressed = compand(data,255,max(data))
//Output arguments:
//compressed =
//8.1644    9.6394   10.5084   11.1268   11.6071   12.
//
//2. out = compand(in,Mu,v,'mu/compressor')
//Input arguments:
//data = 2:2:12
//compressed = compand(data,255,max(data),'mu/compressor')
//Output arguments:
//compressed =
//8.1644    9.6394   10.5084   11.1268   11.6071   12.
//
//3. out = compand(in,Mu,v,'mu/expander')
//Input arguments:
//expanded = compand(compressed,255,max(data),'mu/expander')
//Output arguments:
//expanded =
//2.    4.    6.    8.   10.   12.
//
//4. out = compand(in,A,v,'A/compressor')
//Input arguments:
//data = 1:5
//compressed = compand(data,87.6,max(data),'a/compressor')
//Output arguments:
//compressed =
//3.5296    4.1629    4.5333    4.7961    5.O
//5. out = compand(in,A,v,'A/expander') 
//Input arguments:
//expanded = compand(compressed,87.6,max(data),'a/expander')
//Output arguments details:
//expanded =
//1.    2.    3.    4.    5.
//Resources:
//For the documentation of compand(): http://in.mathworks.com/help/comm/functionlist.html
//For understanding the syntax of Scilab, Scilab functions: http://spoken-tutorial.org/tutorial-search/?search_foss=Scilab&search_language=English
//

//Function definition:
function[y]=compand(varargin) //varargin will store the input arguments
    [lhs,rhs] = argn()// lhs has the left side arguments in this case : y and rhs has right side arguments in this case: in,Mu/A,v,opt
    in=varargin(1)
    mu=varargin(2)
    v=varargin(3)
    if( rhs ==3 ) then //for out = compand(in,param,v) which does not take in the fourth parameter, it is set to ""
        opt=""
    end
    if(rhs == 4) then //if there are four argyments passed, fourth input argument is set to opt
        opt=varargin(4)
    end
    j=1 //index for y
    len = length(in)
    for i = in //loop through x
        if(opt == "mu/compressor") then
           //y=V*log(1+μ|x|/V)*sgn(x)/log(1+μ)
           temp = v*log(1+(mu*abs(i)/v))/log(1+mu)
           temp=temp*signm(i) 
           y(1,j)=round(temp*10^6/10^2)/10^4 //round upto four decimal point
        end
        if(opt == "") then
           //y=V*log(1+μ|x|/V)*sgn(x)/log(1+μ)
           temp = v*log(1+(mu*abs(i)/v))/log(1+mu)
           temp=temp*signm(i) 
           y(1,j)=round(temp*10^6/10^2)/10^4 //round upto four decimal point
        end
        if(opt == "mu/expander") then
            //x=V(e^(|y|*log(1+μ)/V)−1)*sgn(y)/μ
            temp = v*(exp((abs(i)*log(1+mu))/v)-1)*signm(i)
            temp=temp/mu
            y(1,j)=round(round(temp*10^6/10^2)/10^4)//round upto four decimal point
        end
        if(opt == "A/compressor") then
            // for 0 <= |x| <= v/A here A is named as variable mu
            // y= A|x|*sgn(x)/(1+logA)
            if(abs(i) >= 0) then
                if(abs(i) <= v/mu) then
                    temp=mu*abs(i)/(1+log(mu))
                    temp=temp*signm(i)
                    y(1,j)=round(temp*10^6/10^2)/10^4 //round upto four decimal point
                end
            end
            if(abs(i)>v/mu) then
                // for v/A < |x| <= v
                //y= V*(1+log(A|x|/V))*sgn(x)/(1+logA)
                if(abs(i)<=v) then
                    temp=v*(1+log(mu*abs(i)/v))/(1+log(mu))
                    temp=temp*signm(i)
                    y(1,j)=round(temp*10^6/10^2)/10^4 //round upto four decimal point
                end
            end
        end 
        if( opt == "A/expander") then
            //for 0≤ |y| ≤V/(1+logA)
            // x= y*(1+logA)/A
            if(abs(i)>=0) then
                if(abs(i)<=v/(1+log(mu))) then
                    temp=(i*(1+log(mu)))/mu
                    y(1,j)=round(round(temp*10^6/10^2)/10^4) //round upto four decimal point
                end
            end
            if(abs(i)>v/(1+log(mu))) then
                //for V/(1+logA) < |y| ≤ V
                //x= exp(|y|*(1+logA)/V−1)*V*sgn(y)/A
                if(abs(i)<=v) then
                    temp=exp(abs(i)*(1+log(mu))/v-1)*v/mu
                    temp=temp*signm(i)
                    y(1,j)=round(round(temp*10^6/10^2)/10^4) //round upto four decimal point
                end
            end
        end
        j=j+1
    end
endfunction

