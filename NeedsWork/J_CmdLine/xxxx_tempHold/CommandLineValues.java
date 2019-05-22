// https://martin-thoma.com/how-to-parse-command-line-arguments-in-java/
/*  G: java code to parse command line arguments
 * https://www.google.com/search?q=java+code+to+parse+command+line+arguments&safe=active&rlz=1C1GCEB_en___US816&ei=EHHbXLLLNpO50PEPxZy6EA&start=10&sa=N&ved=0ahUKEwiyk4DQtpziAhWTHDQIHUWODgIQ8NMDCL8B&biw=1352&bih=1122
 * 
 */


package theBeginning;

import java.io.File;

import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;

/**
 * This class handles the programs arguments.
 */
public class CommandLineValues {
    @Option(name = "-i", aliases = { "--input" }, required = true,
            usage = "input file with two matrices")
    private File source;

    private boolean errorFree = false;

    public CommandLineValues(String... args) {
        CmdLineParser parser = new CmdLineParser(this);
        parser.setUsageWidth(80);
        try {
            parser.parseArgument(args);

            if (!getSource().isFile()) {
                throw new CmdLineException(parser,
                        "--input is no valid input file.");
            }

            errorFree = true;
        } catch (CmdLineException e) {
            System.err.println(e.getMessage());
            parser.printUsage(System.err);
        }
    }

    /**
     * Returns whether the parameters could be parsed without an
     * error.
     *
     * @return true if no error occurred.
     */
    public boolean isErrorFree() {
        return errorFree;
    }

    /**
     * Returns the source file.
     *
     * @return The source file.
     */
    public File getSource() {
        return source;
    }
}