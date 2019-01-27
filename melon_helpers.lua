function read_memory_8 (addr) return read_memory(8,  addr) end
function read_memory_16(addr) return read_memory(16, addr) end
function read_memory_32(addr) return read_memory(32, addr) end
function read_memory_64(addr) return read_memory(64, addr) end
function write_memory_8 (addr, value) return write_memory(8,  addr, value) end
function write_memory_16(addr, value) return write_memory(16, addr, value) end
function write_memory_32(addr, value) return write_memory(32, addr, value) end
function write_memory_64(addr, value) return write_memory(64, addr, value) end


function printf(...) return print(string.format(...)) end


breakpoints = {}
function set_breakpoint_callback(address, callback)
    register_breakpoint(address)
    breakpoints[address] = callback
end
function handle_instruction_run(arm9, arm7, whichCpu)
    local cpu = (whichCpu == 9 and arm9 or arm7)
    local callback = breakpoints[cpu.Reg[16] - 4]
    if callback ~= nil then
        callback(arm9, arm7, whichCpu)
    else
        printf('handle_instruction_run: %08X', cpu.Reg[16])
    end
end


read_watchpoints = {}
function set_read_watchpoint_callback(address, callback)
    register_read_watchpoint(address)
    read_watchpoints[address] = callback
end
function handle_memory_read(arm9, arm7, whichCpu, size, addr, value)
    local callback = read_watchpoints[addr]
    if callback ~= nil then
        value = callback(arm9, arm7, whichCpu, size, addr, value)
    else
        printf('handle_memory_read: %08X', addr)
    end
    return value
end


write_watchpoints = {}
function set_write_watchpoint_callback(address, callback)
    register_write_watchpoint(address)
    write_watchpoints[address] = callback
end
function handle_memory_write(arm9, arm7, whichCpu, size, addr, value)
    local callback = write_watchpoints[addr]
    if callback ~= nil then
        value = callback(arm9, arm7, whichCpu, size, addr, value)
    else
        printf('handle_memory_write: %08X', addr)
    end
    return value
end
