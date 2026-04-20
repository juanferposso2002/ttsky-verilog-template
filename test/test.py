import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock


@cocotb.test()
async def test_safe(dut):

    dut._log.info("Start test")

    # Start clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Reset
    dut.rst_n.value = 0
    for _ in range(5):
        await RisingEdge(dut.clk)

    dut.rst_n.value = 1

    for _ in range(5):
        await RisingEdge(dut.clk)

    # Apply LEFT mode
    dut.ui_in.value = 0b01

    for i in range(10):
        await RisingEdge(dut.clk)

        if dut.uo_out.value.is_resolvable:
            val = dut.uo_out.value.integer
            dut._log.info(f"Cycle {i}: {val:08b}")
        else:
            dut._log.warning(f"Cycle {i}: UNDEFINED (X/Z)")