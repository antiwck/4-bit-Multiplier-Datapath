# 4-bit-Multiplier-Datapath
A 4-bit multiplier designed using Datapath concept which allows timing to be adjusted to control data flow of computation.

The program is compiled in Intel Quartus Prime and run under the testbench to perform the functional computation.
The 4-bit multiplier takes two 4-bit number in binary and multiply the two to produce a result that reflects the computation.
The datapath consists of two 4-bit registers, one 4-bit multiplier and one 8-bit register.
The 4-bit register stores the value for the two binary numbers and the 8-bit register store the final computed result.
The timing for the dataflow is controlled by a clock signal and the loading of register is dependent on the rising clock edge.


![Datapath Design](https://github.com/antiwck/4-bit-Multiplier-Datapath/blob/888b7289f3dd57e0bd18e78a9959bef06a4a0b01/Sources/Datapath%20design.jpg)

![Result computation](https://github.com/antiwck/4-bit-Multiplier-Datapath/blob/888b7289f3dd57e0bd18e78a9959bef06a4a0b01/Sources/Result.jpg)

First computation:
First number  : 0110 (6)
Second number : 1100 (12)
Result        : 01001000 (72)

Second computation:
First number  : 0010 (2)
Second number : 0001 (1)
Result        : 00000010 (2)
