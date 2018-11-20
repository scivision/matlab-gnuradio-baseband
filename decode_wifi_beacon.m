function decode_wifi_beacon(bbfn)
% based on Matlab WLAN Toolbox example
% https://www.mathworks.com/help/wlan/examples/802-11-ofdm-beacon-receiver-with-live-data.html
%
% requires Matlab WLAN Toolbox (e.g. for nonHTFrontEnd, etc.)

assert(~isempty(ver('comm')), 'Matlab Communications Toolbox is required')

hr = comm.BasebandFileReader(bbfn, ...
    'SamplesPerFrame', 80); % Number of samples in 1 OFDM symbol at 20 MHz

rxFrontEnd = nonHTFrontEnd('ChannelBandwidth', 'CBW20');

% A recovery configuration object is used to specify zero-forcing
% equalization for the data recovery
cfgRec = wlanRecoveryConfig('EqualizationMethod', 'ZF');

% Symbol-by-symbol streaming process
numValidPackets = 0;
while ~isDone(hr)
    % Pull in one OFDM symbol, i.e. 80 samples
    data = hr();

    % Perform front-end processing and payload buffering
    [payloadFull, cfgNonHT, rxNonHTData, chanEst, noiseVar] = ...
        rxFrontEnd(data);

    if payloadFull
        % Recover payload bits
        recBits = wlanNonHTDataRecover(rxNonHTData, chanEst, ...
            noiseVar, cfgNonHT, cfgRec);

        % Evaluate recovered bits
        [validBeacon, MPDU] = nonHTBeaconRxMPDUDecode(recBits);
        if validBeacon
            nonHTBeaconRxOutputDisplay(MPDU); % Display SSID
            numValidPackets = numValidPackets + 1;
        end
    end
end

disp([num2str(numValidPackets), ' Valid Beacon Packets Found']);

release(hr);
release(rxFrontEnd);
end