import cocotb
from cocotb.triggers import RisingEdge, Timer


@cocotb.test()
async def test_project(dut):

    dut._log.info("Start")

    # Enable design
    dut.ena.value = 1

    # Initialize inputs
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Apply reset (active LOW)
    dut._log.info("Reset")
    dut.rst_n.value = 0
    await Timer(1, units="us")
    dut.rst_n.value = 1

    # Wait a couple clock cycles
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

    # Function to read outputs
    def read_outputs():
        left  = dut.uo_out.value & 0b00000111
        right = (dut.uo_out.value >> 3) & 0b00000111
        return left, right

    # Test modes
    modes = {
        "OFF": 0b00,
        "LEFT": 0b01,
        "RIGHT": 0b10,
        "HAZARD": 0b11
    }

    for mode_name, mode_val in modes.items():

        dut._log.info(f"Testing mode: {mode_name}")

        # Apply blinker to ui_in[1:0]
        dut.ui_in.value = mode_val

        # Run several clock cycles
        for i in range(6):
            await RisingEdge(dut.clk)

            left, right = read_outputs()

            dut._log.info(
                f"Cycle {i} | LEFT = {left:03b} | RIGHT = {right:03b}"
            )