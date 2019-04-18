//: IOStreamDemo.java
//////////////////////////////////////////////////
// Copyright (c) Bruce Eckel, 1998
// Source code file from the book "Thinking in Java"
// All rights reserved EXCEPT as allowed by the
// following statements: You can freely use this file
// for your own work (personal or commercial),
// including modifications and distribution in
// executable form only. Permission is granted to use
// this file in classroom situations, including its
// use in presentation materials, as long as the book
// "Thinking in Java" is cited as the source. 
// Except in classroom situations, you cannot copy
// and distribute this code; instead, the sole
// distribution point is http://www.BruceEckel.com 
// (and official mirror sites) where it is
// freely available. You cannot remove this
// copyright and notice. You cannot distribute
// modified versions of the source code in this
// package. You cannot use this file in printed
// media without the express permission of the
// author. Bruce Eckel makes no representation about
// the suitability of this software for any purpose.
// It is provided "as is" without express or implied
// warranty of any kind, including any implied
// warranty of merchantability, fitness for a
// particular purpose or non-infringement. The entire
// risk as to the quality and performance of the
// software is with you. Bruce Eckel and the
// publisher shall not be liable for any damages
// suffered by you or any third party as a result of
// using or distributing software. In no event will
// Bruce Eckel or the publisher be liable for any
// lost revenue, profit, or data, or for direct,
// indirect, special, consequential, incidental, or
// punitive damages, however caused and regardless of
// the theory of liability, arising out of the use of
// or inability to use software, even if Bruce Eckel
// and the publisher have been advised of the
// possibility of such damages. Should the software
// prove defective, you assume the cost of all
// necessary servicing, repair, or correction. If you
// think you've found an error, please email all
// modified files with clearly commented changes to:
// Bruce@EckelObjects.com. (Please use the same
// address for non-code errors found in the book.)
/////////////////////////////////////////////////

// Typical IO Stream Configurations
import java.io.*;
import com.bruceeckel.tools.*;

public class IOStreamDemo {
  public static void main(String[] args) {
    try {
      // 1. Buffered input file
      DataInputStream in =
        new DataInputStream(
          new BufferedInputStream(
            new FileInputStream(args[0])));
      String s, s2 = new String();
      while((s = in.readLine())!= null)
        s2 += s + "\n";
      in.close();

      // 2. Input from memory
      StringBufferInputStream in2 =
          new StringBufferInputStream(s2);
      int c;
      while((c = in2.read()) != -1)
        System.out.print((char)c);

      // 3. Formatted memory input
      try {
        DataInputStream in3 =
          new DataInputStream(
            new StringBufferInputStream(s2));
        while(true)
          System.out.print((char)in3.readByte());
      } catch(EOFException e) {
        System.out.println(
          "End of stream encountered");
      }

      // 4. Line numbering & file output
      try {
        LineNumberInputStream li =
          new LineNumberInputStream(
            new StringBufferInputStream(s2));
        DataInputStream in4 =
          new DataInputStream(li);
        PrintStream out1 =
          new PrintStream(
            new BufferedOutputStream(
              new FileOutputStream(
                "IODemo.out")));
        while((s = in4.readLine()) != null )
          out1.println(
            "Line " + li.getLineNumber() + s);
        out1.close(); // finalize() not reliable!
      } catch(EOFException e) {
        System.out.println(
          "End of stream encountered");
      }

      // 5. Storing & recovering data
      try {
        DataOutputStream out2 =
          new DataOutputStream(
            new BufferedOutputStream(
              new FileOutputStream("Data.txt")));
        out2.writeBytes(
          "Here's the value of pi: \n");
        out2.writeDouble(3.14159);
        out2.close();
        DataInputStream in5 =
          new DataInputStream(
            new BufferedInputStream(
              new FileInputStream("Data.txt")));
        System.out.println(in5.readLine());
        System.out.println(in5.readDouble());
      } catch(EOFException e) {
        System.out.println(
          "End of stream encountered");
      }

      // 6. Reading/writing random access files
      RandomAccessFile rf =
        new RandomAccessFile("rtest.dat", "rw");
      for(int i = 0; i < 10; i++)
        rf.writeDouble(i*1.414);
      rf.close();

      rf =
        new RandomAccessFile("rtest.dat", "rw");
      rf.seek(5*8);
      rf.writeDouble(47.0001);
      rf.close();

      rf =
        new RandomAccessFile("rtest.dat", "r");
      for(int i = 0; i < 10; i++)
        System.out.println(
          "Value " + i + ": " +
          rf.readDouble());
      rf.close();

      // 7. File input shorthand
      InFile in6 = new InFile(args[0]);
      String s3 = new String();
      System.out.println(
        "First line in file: " +
        in6.readLine());
        in6.close();

      // 8. Formatted file output shorthand
      PrintFile out3 = new PrintFile("Data2.txt");
      out3.print("Test of PrintFile");
      out3.close();

      // 9. Data file output shorthand
      OutFile out4 = new OutFile("Data3.txt");
      out4.writeBytes("Test of outDataFile\n\r");
      out4.writeChars("Test of outDataFile\n\r");
      out4.close();

    } catch(FileNotFoundException e) {
      System.out.println(
        "File Not Found:" + args[0]);
    } catch(IOException e) {
      System.out.println("IO Exception");
    }
  }
} ///:~