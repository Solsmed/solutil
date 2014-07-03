function [ audioData ] = decodeALaw( encodedData )
%DECODEALAW Decodes G.711 encoded audio stream data
%   Implementation of snippet found on
%   http://en.wikipedia.org/wiki/G.711#A-Law
    
    ix = bitxor(uint16(encodedData),uint16(hex2dec('55'))); % re-toggle toggled bits
    ix = bitand(uint16(ix),uint16(hex2dec('7F'))); % remove sign bit
    iexp = bitshift(ix,-4,'uint16'); % extract exponent
    mant = bitand(ix,uint16(hex2dec('0F'))); % now get mantissa
    mant(iexp > 0) = mant(iexp > 0) + 16; % add leading '1', if exponent > 0
    mant = bitshift(mant,4) + uint16(hex2dec('08')); % now mantissa left justified and 1/2 quantization step added
    mant(iexp > 1) = bitshift(mant(iexp > 1), (iexp(iexp > 1) - 1)); % now left shift according exponent
    
    % invert, if negative sample
    audioData = nan(size(encodedData));
    pos = encodedData > 127;
    audioData(pos) = mant(pos);
    audioData(~pos) = -double(mant(~pos));
end
