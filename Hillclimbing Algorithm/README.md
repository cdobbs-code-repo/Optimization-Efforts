
The Hillclimbing algorithm included is designed to solve the bus voltages, V1 and V2, and source voltages, Vs1 and Vs2, for a two source system with Vs1 / Zs1 on the V1 bus side, Vs2 / Zs2 on the V2 bus side, and ZL between the buses. Apparent power at both buses is given, impendances are given, and all voltages are constrained to +/- 5% of Vnom = 100V.

In other words, we have 8 unknown variables (Vs1_real, Vs1_imag, V1_real, V1_imag, Vs2_real...) we need to slowly tweak until the residual (expected power - calculated power) is less than 10^-6.