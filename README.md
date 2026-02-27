# fifo_synchro

📦 Parameterized Synchronous FIFO (Verilog)
📌 Overview

This project implements a parameterized Synchronous FIFO (First-In First-Out) using Verilog HDL.

The design supports configurable data width and depth and includes proper circular buffer logic, full/empty flag generation, and structured testbench verification.

This project focuses on RTL design fundamentals and waveform-level debugging.

🏗 Design Specifications
Parameter	Description
DATA_WIDTH	Width of input/output data
DEPTH	Number of storage locations

Example configuration:

parameter data_width = 8;
parameter depth = 8;
🧠 Architecture

The FIFO consists of:

Memory array

Write pointer

Read pointer

Occupancy counter

Full flag

Empty flag

Memory Declaration
reg [data_width-1:0] memory [0:depth-1];
Pointer Width
localparam PTR_WIDTH = $clog2(depth);

Pointers automatically adjust based on depth.

⚙️ Functional Description
✅ Write Operation

Occurs when wrt_enable = 1 and FIFO is not full

Data written into memory

Write pointer increments with wrap-around logic

✅ Read Operation

Occurs when read_enable = 1 and FIFO is not empty

Data read from memory

Read pointer increments with wrap-around logic

✅ Circular Buffer Logic
write_pointer <= (write_pointer == depth-1) ? 0 : write_pointer + 1;
read_pointer  <= (read_pointer  == depth-1) ? 0 : read_pointer  + 1;

Prevents memory overflow.

🚩 Status Flag Logic
assign full  = (count == depth);
assign empty = (count == 0);
Count Update Logic
Write	Read	Count Change
1	0	+1
0	1	-1
1	1	No Change
0	0	No Change

Simultaneous read/write keeps FIFO occupancy constant.

🔄 Reset Behavior

Synchronous reset initializes:

Write pointer

Read pointer

Count

Output data

Ensures no undefined (X) propagation in simulation.

🧪 Testbench

The testbench verifies:

Proper reset sequencing

Sequential writes

Sequential reads

Full and Empty flag behavior

Correct data ordering (FIFO property)

Clock Generation
always #10 clk = ~clk;
📊 Simulation

Simulation verifies:

FIFO correctly stores and retrieves data

Full and Empty signals behave as expected

No overflow or underflow occurs

Proper handling of simultaneous read/write

📁 Project Structure
fifo_project/
│
├── rtl/
│   └── fifo_practice.v
│
├── tb/
│   └── fifo_practice_tb.v
│
└── README.md
🎯 Key Learnings

Importance of non-blocking assignments in sequential logic

Proper pointer wrap-around in circular buffers

Handling simultaneous read/write conditions

Avoiding X-propagation through proper reset design

Writing deterministic testbenches

🚀 Future Improvements

Almost Full / Almost Empty flags

Asynchronous FIFO (dual-clock design)

Functional coverage-driven verification

Synthesis & timing analysis

UVM-based verification

👩‍💻 Author

Lakshmi Pujitha Chaganti
Electronics & Communication Engineering
Focused on RTL Design and VLSI
