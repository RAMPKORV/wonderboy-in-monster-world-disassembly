//DumpDisasm.java
//Dumps image-memory instructions (addr\tmnemonic\toperand0\toperand1) to args[0].
//@category GenesisDisasm
import java.io.*;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;

public class DumpDisasm extends GhidraScript {
    public void run() throws Exception {
        String out = getScriptArgs()[0];
        BufferedWriter w = new BufferedWriter(new FileWriter(out));
        InstructionIterator it = currentProgram.getListing().getInstructions(true);
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
        println("DUMP-OK " + out);
    }
}