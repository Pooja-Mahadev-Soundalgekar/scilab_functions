# scilab_functions
Implementation of compand() and bersync() functions of Matlab in Scilab. Check Matlab documentation to understand the function's working.
I have made both .sci and .sce for both the functions. The code is the same just the extension is different.
On scilab console, there is an 'open a file' icon. Click on it and go to the directory where the function code is present. Click on the .sci and it will open in SciNotes. On the top there is an execute option. Click on it and select 'save and execute'. Alternatively to execute you can type this on the console: execute('path of the .sci/.sce',-1) 
To get the full path of the file, go to the file in SciNotes, right click and select 'copy full path'.


For compand() function:


out = compand(in,param,v)
out = compand(in,Mu,v,'mu/compressor')
out = compand(in,Mu,v,'mu/expander')
out = compand(in,A,v,'A/compressor')
out = compand(in,A,v,'A/expander') 
these are the possible argument passing.
in is a data array, param/Mu/A and v are numbers and fourth parameters are strings. 

out = compand(in,param,v) implements a µ-law compressor for the input vector in. Mu specifies µ, and v is the input signal's maximum magnitude. out has the same dimensions and maximum magnitude as in.

out = compand(in,Mu,v,'mu/compressor') is the same as the syntax above.

out = compand(in,Mu,v,'mu/expander') implements a µ-law expander for the input vector in. Mu specifies µ and v is the input signal's maximum magnitude. out has the same dimensions and maximum magnitude as in.

out = compand(in,A,v,'A/compressor') implements an A-law compressor for the input vector in. The scalar A is the A-law parameter, and v is the input signal's maximum magnitude. out is a vector of the same length and maximum magnitude as in.

out = compand(in,A,v,'A/expander') implements an A-law expander for the input vector in. The scalar A is the A-law parameter, and v is the input signal's maximum magnitude. out is a vector of the same length and maximum magnitude as in.

On the Scilab Console after executing the function, type the following in order:
Example for 'mu/compressor':
data = 2:2:12
compressed = compand(data,255,max(data),'mu/compressor') or compressed = compand(data,255,max(data))
Output displayed will be:
compressed =
    8.1644    9.6394   10.5084   11.1268   11.6071   12.
Example for 'mu/expander':
Next Type:
expanded = compand(compressed,255,max(data),'mu/expander')
Output displayed will be:
expanded =
    2.   4.    6.    8.  10.   12.
Example for 'A/compressor':
Next type:
data = 1:5
compressed = compand(data,87.6,max(data),'A/compressor')
Output displayed will be:
compressed =
    3.5296    4.1629    4.5333    4.7961    5.
Example for 'A/expander:
expanded = compand(compressed,87.6,max(data),'A/expander')
expanded =
    1.    2.    3.    4.    5.



For bersync() function:
ber = bersync(EbNo,timerr,'timing')
ber = bersync(EbNo,phaserr,'carrier')
these are the possible argument passing.
Here, EbNo is a Array and timerr is a number value and the third parameter is string, either 'timing' or 'carrier'.

ber = bersync(EbNo,timerr,'timing') returns the BER of uncoded coherent binary phase shift keying (BPSK) modulation over an additive white Gaussian noise (AWGN) channel with imperfect timing. The normalized timing error is assumed to have a Gaussian distribution. EbNo is the ratio of bit energy to noise power spectral density, in dB. If EbNo is a vector, the output ber is a vector of the same size, whose elements correspond to the different Eb/N0 levels.

ber = bersync(EbNo,phaserr,'carrier') returns the BER of uncoded BPSK modulation over an AWGN channel with a noisy phase reference. The phase error is assumed to have a Gaussian distribution. phaserr is the standard deviation of the error in the reference carrier phase, in radians.



On the Scilab Console after executing the function, type the following in order:
Example for 'timing':
EbNo = [4 8] 
timerr = 0.2 
ber = bersync(EbNo,timerr,'timing')
Output displayed will be:
ber =   0.0520727    0.0205365
Example for 'carrier':
Next Type:
EbNo = [4 5]
phaserr= 0.1
ber = bersync(EbNo,phaserr,'carrier')
Output displayed will be:
ber = 0.0128766    0.0061761












