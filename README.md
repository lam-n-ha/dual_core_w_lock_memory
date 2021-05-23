# dual_core_w_lock_memory
Dual core RISC-V processor with shared memory with locking functionality

This is a dual core implementation of the tiny_risc_v project, which can be found: https://github.com/lam-n-ha/tiny_risc_v/
The project includes 2 tiny_risc_v cores and a shared 2-port on chip memory with lock.
The locking functionality when activated spin one of the two cores in its current state to avoid mismatching data. 
Four instructions have been added
  - GSW - Global Store Word: store information to the shared memory
  - GLW - Global Load Word: load information from the shared memory
  - AFL - ask for lock: turn on the need_lock signal, signaling that the core needs a lock
  - NML - no more lock: turn off the need_lock signal, signaling that the core no longer need a lock
included is a benchmark dualcore.txt, the instructions of which has been loaded into the two cores' memory initialization file .mif that can be used to test the locking functionality
