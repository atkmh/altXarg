// From: http://journals.ecs.soton.ac.uk/java/tutorial/java/cmdLineArgs/parsing.html
// Via G: java code to parse command line arguments
/* https://www.google.com/search?q=java+code+to+parse+command+line+arguments&rlz=1C1GCEB_en___US816&oq=java+examples+of+parsing+command+line+input&aqs=chrome.1.69i57j0.12465j0j7&sourceid=chrome&ie=UTF-8&safe=active */

package theBeginning;

public class ParseCmdLine {
    public static void main(String[] args) {

        int i = 0, j;
        String arg;
        char flag;
        boolean vflag = false;
        boolean fFlag = false;
        boolean cFlag = false;
        
        String outputfile = "";

        while (i < args.length && args[i].startsWith("-")) {
            arg = args[i++];

    // use this type of check for "wordy" arguments
            if (arg.equals("-verbose")) {
                System.out.println("verbose mode on");
                vflag = true;
            }

    // use this type of check for "file" arguments
            if (arg.equals("-f")) {
                System.out.println("file mode on");
                fFlag = true;
            }

            
            
    // use this type of check for arguments that require arguments
            else if (arg.equals("-output")) {
                if (i < args.length)
                    outputfile = args[i++];
                else
                    System.err.println("-output requires a filename");
                if (vflag)
                    System.out.println("output file = " + outputfile);
            }

    // use this type of check for a series of flag arguments
            else {
                for (j = 1; j < arg.length(); j++) {
                    flag = arg.charAt(j);
                    switch (flag) {
                    case 'x':
                        if (vflag) System.out.println("Option x");
                        break;
                    case 'n':
                        if (vflag) System.out.println("Option n");
                        break;
                    default:
                        System.err.println("ParseCmdLine: illegal option " + flag);
                        break;
                    }
                }
            }
        }
        if (i == args.length)
            System.err.println("Usage: ParseCmdLine [-verbose] [-xn] [-output afile] filename");
        else
            System.out.println("Success!");
    }
}