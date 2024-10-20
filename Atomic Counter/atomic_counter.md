<h1>Atomic Counter</h1>
This problem involves designing a 64-bit counter that is to be read by a 32-bit bus.<br>
The peripheral bus is driven by a controller which wants to read the entire 64-bit value.<br>
The controller asserts a request twice to fetch msb(32-bits) and lsb (32-bits) of the counter.<br>
The controller concatenates the two values to get the complete 64-bit data.<br>
We have a trigger signal that gives the input to increment the counter by 1.<br>
The atomic signal indicates that we should return the lsb (32-bits) when it is asserted and msb (32-bits) when it is deasserted.<br>
The ack signal acknowledges output from counter.<br>
<br>
<img width="452" alt="atomiccounter" src="https://github.com/user-attachments/assets/377ae2d7-77fd-4ecf-a385-f02ef7340c54">
