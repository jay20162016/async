# async
Asynchronous Circuits!!!!!!!!!!!!!!


In this repo is my progress on asynchronous circuits. They use the 4-phase bundled data protocol.

[√] lut - Lookup table. Edit the `SB_LUT4` part to your fpga's lut primative.
[√] loop_breaker - Blackbox module to make sure yosys doesn't break combinatorical loops.

[√] delay_multi - Delays. Used to ensure request comes after data validity.
[√] delay_one
[√] delay

[√] dlatch - D latch. Propangate data on enable.
[√] mullerc - Muller C element. Propangate inputs when they're the same, otherwise hold data.

[√] source - Keeps on handshaking.
[√] sink - Keeps on acknowledging

[√] hlatch - Handshaking latch.

[√] combine - Combines/Joins handshakes, AND-wise.
[√] split - Splits/Forks handshakes.

[√] merge - Merges handshakes, OR-wise.
[√] merge2 - Same as merge, but acknowledge is only sent to the handshaker.

[√] mux - Multiplexes, control is dual-rail.
[√] mux2 - Multiplexes, control is bundled-data.

[ ] demux - Demultiplexer, not implemented yet.

