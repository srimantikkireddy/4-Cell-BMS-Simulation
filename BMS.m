function [SoC, Fault] = BMS_Controller(V, I)
persistent soc
dt = 1; % time step (in seconds)
C = 2 * 3600; % battery capacity (2Ah in Coulombs)

if isempty(soc)
    soc = 0.5;  % 50% initial SoC
end

soc = soc - (I * dt) / C;
soc = max(0, min(1, soc));

% Fault detection (over-voltage or under-voltage)
if any(V > 4.2) || any(V < 3.0)
    Fault = 1;
else
    Fault = 0;
end

SoC = soc * 100; 
end
