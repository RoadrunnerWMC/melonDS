dofile("../melon_helpers.lua")


function handle_createActor(arm9, arm7, whichCpu)
    local cpu = (whichCpu == 9 and arm9 or arm7)
    local R0,  R1,  R2,  R3 = cpu.Reg[1], cpu.Reg[ 2], cpu.Reg[ 3], cpu.Reg[ 4]
    local R4,  R5,  R6,  R7 = cpu.Reg[5], cpu.Reg[ 6], cpu.Reg[ 7], cpu.Reg[ 8]
    local R8,  R9, R10, R11 = cpu.Reg[9], cpu.Reg[10], cpu.Reg[11], cpu.Reg[12]
    local R12 = cpu.Reg[13]     -- R12
    local SP = cpu.Reg[14]      -- R13
    local LR = cpu.Reg[15] - 4  -- R14
    local PC = cpu.Reg[16] - 4  -- R15
    local CPSR = cpu.Cpsr; local isThumb = ((CPSR & 0x20) == 0x20)

    printf('createActor() called from %08X!', LR)
end
set_breakpoint_callback(0x020A0B64, handle_createActor)



function handle_areaNum_read(arm9, arm7, whichCpu, size, addr, value)
    local cpu = (whichCpu == 9 and arm9 or arm7)
    local R0,  R1,  R2,  R3 = cpu.Reg[1], cpu.Reg[ 2], cpu.Reg[ 3], cpu.Reg[ 4]
    local R4,  R5,  R6,  R7 = cpu.Reg[5], cpu.Reg[ 6], cpu.Reg[ 7], cpu.Reg[ 8]
    local R8,  R9, R10, R11 = cpu.Reg[9], cpu.Reg[10], cpu.Reg[11], cpu.Reg[12]
    local R12 = cpu.Reg[13]     -- R12
    local SP = cpu.Reg[14]      -- R13
    local LR = cpu.Reg[15] - 4  -- R14
    local PC = cpu.Reg[16] - 8  -- R15
    local CPSR = cpu.Cpsr; local isThumb = ((CPSR & 0x20) == 0x20)

    printf("AreaNum read from %08X on ARM%d: %d", PC, whichCpu, value)

    return value
end
set_read_watchpoint_callback(0x02085A94, handle_areaNum_read)



function handle_areaNum_write(arm9, arm7, whichCpu, size, addr, value)
    local cpu = (whichCpu == 9 and arm9 or arm7)
    local R0,  R1,  R2,  R3 = cpu.Reg[1], cpu.Reg[ 2], cpu.Reg[ 3], cpu.Reg[ 4]
    local R4,  R5,  R6,  R7 = cpu.Reg[5], cpu.Reg[ 6], cpu.Reg[ 7], cpu.Reg[ 8]
    local R8,  R9, R10, R11 = cpu.Reg[9], cpu.Reg[10], cpu.Reg[11], cpu.Reg[12]
    local R12 = cpu.Reg[13]     -- R12
    local SP = cpu.Reg[14]      -- R13
    local LR = cpu.Reg[15] - 4  -- R14
    local PC = cpu.Reg[16] - 8  -- R15
    local CPSR = cpu.Cpsr; local isThumb = ((CPSR & 0x20) == 0x20)

    printf("AreaNum written to from %08X on ARM%d: %d", PC, whichCpu, value)

    return value
end
set_write_watchpoint_callback(0x02085A94, handle_areaNum_write)
