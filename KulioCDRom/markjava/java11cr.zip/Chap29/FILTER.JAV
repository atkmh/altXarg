import java.io.*;
public class Filter {
  public static void main(String args[]) {
    try {
      BufferedReader br = new BufferedReader(new FileReader(args[0]));
      BufferedWriter bw = new BufferedWriter(new FileWriter(args[1]));
      String line;
      boolean programFlag = false;
      while((line = br.readLine()) != null) {
        if(line.startsWith("Listing ")) {
          programFlag = true;
          continue;
        }
        if(line.startsWith("$eol")) {
          programFlag = false;
          continue;
        }
        if(programFlag) {
          line += "\r\n";
          bw.write(line, 0, line.length());
        }
      }
      bw.flush();
      bw.close();
    }
    catch(Exception e) {
      System.out.println("Exception: " + e);
    }
  }
}

        