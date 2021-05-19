# async
Asynchronous Circuits!!!!!!!!!!!!!!


In this repo is my progress on asynchronous circuits. They use the 4-phase bundled data protocol.  

Following is a description of each:

lut - Lookup table. Edit the `SB_LUT4` part to your fpga's lut primative.  
loop_breaker - Blackbox module to make sure yosys doesn't break combinatorical loops.  

delay_multi - Delays. Used to ensure request comes after data validity.  
delay_one.  
delay.  

dlatch - D latch. Propangate data on enable.  

mullerc - Muller C element. Propangate inputs when they're the same, otherwise hold data.  

source - Keeps on handshaking.  
sink - Keeps on acknowledging.  

hlatch - Handshaking latch.  

combine - Combines/Joins handshakes, AND-wise.  
split - Splits/Forks handshakes.  

merge - Merges handshakes (assuming mutual exclusion), OR-wise.  
merge2 - Same as merge, but acknowledge is only sent to the handshaker.  

mux - Multiplexes, control is dual-rail.  
mux2 - Multiplexes, control is bundled-data.  

demux - Demultiplexer, control is dual-rail.  
demux2 - Demultiplexer, control is bundled-data.   

cond_sink - Conditional Sink, control is dual-rail.  
cond_sink2 - Conditional Sink, control is bundled-data.  

swap - Swap handshakes. Control is dual-rail.  
swap2 - Swap handshakes. Control is bundled-data.  

swap_sink - Chooses a handshake. Other one is discarded. Control is dual-rail.  
swap_sink2 - Chooses a handshake. Other one is discarded. Control is bundled-data.  

sr_latch - SR latch  
mutex - mutual exclusion element, first handshake is given priority  
arbiter - merges handshakes (no need for mutual exclusion), first handshake is given priority  
