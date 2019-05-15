// https://martin-thoma.com/how-to-parse-command-line-arguments-in-java/
/*  G: java code to parse command line arguments
 * https://www.google.com/search?q=java+code+to+parse+command+line+arguments&safe=active&rlz=1C1GCEB_en___US816&ei=EHHbXLLLNpO50PEPxZy6EA&start=10&sa=N&ved=0ahUKEwiyk4DQtpziAhWTHDQIHUWODgIQ8NMDCL8B&biw=1352&bih=1122
 * 
 */


package theBeginning;

import java.util.ArrayList;
import java.util.List;

import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;

public class CmdLineValuesRunner {

	public static void main(String[] args) {
	    CommandLineValues values = new CommandLineValues(args);
	    CmdLineParser parser = new CmdLineParser(values);

	    try {
	        parser.parseArgument(args);
	    } catch (CmdLineException e) {
	        System.exit(1);
	    }

	    // Now you can use the command line values
	    List<ArrayList<ArrayList<Integer>>> matrices = read(values.getSource());
	    ArrayList<ArrayList<Integer>> A = matrices.get(0);
	    ArrayList<ArrayList<Integer>> B = matrices.get(1);
	    int[][] C = ijkAlgorithm(A, B);
	    printMatrix(C);
	}
}
