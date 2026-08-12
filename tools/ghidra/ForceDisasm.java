//ForceDisasm.java - Ghidra headless post-script.
//Force-disassembles a memory range [startHex,endHex) (args[0], args[1]),
//then dumps every instruction (address, mnemonic, operands) to args[2].
//Overrides Ghidra's control-flow-only analysis so ANY ROM range can be
//decoded authoritatively. Data that can't decode as code is left out.
//@category GenesisDisasm
import ghidra.app.script.GhidraScript;
import ghidra.program.disassemble.Disassembler;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSet;
import ghidra.program.model.listing.*;
import java.io.BufferedWriter;
import java.io.FileWriter;

public class ForceDisasm extends GhidraScript {
    public void run() throws Exception {
        long start = Long.parseLong(getScriptArgs()[0], 16);
        long end   = Long.parseLong(getScriptArgs()[1], 16);
        String out = getScriptArgs()[2];

        Address a0 = currentProgram.getAddressFactory().getDefaultAddressSpace().getAddress(start);
        Address a1 = currentProgram.getAddressFactory().getDefaultAddressSpace().getAddress(end - 1);
        // clear stale code units so the force-decode starts from the raw bytes
        currentProgram.getListing().clearCodeUnits(a0, a1, true, monitor);
        AddressSet set = new AddressSet(a0, a1);
        Disassembler dis = Disassembler.getDisassembler(currentProgram, monitor, null);
        dis.disassemble(set, null, false);

        BufferedWriter w = new BufferedWriter(new FileWriter(out));
        InstructionIterator it = currentProgram.getListing().getInstructions(set, true);
        while (it.hasNext() && !monitor.isCancelled()) {
            Instruction ins = it.next();
            long a = ins.getAddress().getOffset();
            StringBuilder sb = new StringBuilder();
            sb.append("0x").append(Long.toHexString(a).toUpperCase());
            sb.append("\t").append(ins.getMnemonicString());
            sb.append("\t").append(ins.getDefaultOperandRepresentation(0));
            int n = ins.getNumOperands();
            for (int i = 1; i < n; i++)
                sb.append(", ").append(ins.getDefaultOperandRepresentation(i));
            w.write(sb.toString() + "\n");
        }
        w.close();
        println("FORCE-DISASM-OK " + out);
    }
}