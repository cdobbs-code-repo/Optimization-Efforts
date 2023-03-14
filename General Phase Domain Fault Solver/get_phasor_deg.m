function [mag,ang_deg] = get_phasor_deg(complex_val)
    mag = sqrt( real(complex_val)*real(complex_val) + imag(complex_val)*imag(complex_val) );
    ang_deg = atan2d(imag(complex_val),real(complex_val));
end