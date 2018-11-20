function bin2bb(binfn, fs, fc)
%% bin2bb(binfn, fs)
%
% This uses Matlab non-free toolboxes.
%
% input
% -----
% binfn: GNU Radio .bin filename
% fs: sample frequency [Hz]
% fc: RF center frequency [Hz]
%
% example:
% bin2bb('foo.bin', 20e6)
% writes 20 MS/s Matlab baseband file 'foo.bb'

assert(~isempty(ver('comm')), 'Matlab Communications Toolbox is required')

validateattributes(binfn, {'char'}, {'vector'})
validateattributes(fs, {'numeric'}, {'scalar','positive'})
validateattributes(fc, {'numeric'}, {'scalar','positive'})
%% read GNU radio .bin file into complex64 vector of time-series data
finf = dir(binfn);
filesize = finf.bytes;
memavail = memfree();
if filesize > 0.25*memavail, warning([binfn,' may be too large to fit in your computer RAM']), end
baseband = read_complex_binary(binfn);
%% prepare for writing of Matlab .bb file
[path,stem] = fileparts(binfn);

bbfn = [path,filesep,stem, '.bb'];

hw = comm.BasebandFileWriter(bbfn, fs, fc);


hw(baseband)
release(hw)
end

