//: Buttons.java
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

// Various Swing buttons
package c13.swing;
import java.awt.*;
import java.awt.event.*;
import java.awt.swing.*;
import java.awt.swing.plaf.basic.*;
import java.awt.swing.border.*;

public class Buttons extends JPanel {
  JButton jb = new JButton("JButton");
  BasicArrowButton
    up = new BasicArrowButton(
      BasicArrowButton.NORTH),
    down = new BasicArrowButton(
      BasicArrowButton.SOUTH),
    right = new BasicArrowButton(
      BasicArrowButton.EAST),
    left = new BasicArrowButton(
      BasicArrowButton.WEST);
  Spinner spin = new Spinner(47, "");
  StringSpinner stringSpin = 
    new StringSpinner(3, "",
      new String[] { 
        "red", "green", "blue", "yellow" });
  public Buttons() {
    add(jb);
    add(new JToggleButton("JToggleButton"));
    add(new JCheckBox("JCheckBox"));
    add(new JRadioButton("JRadioButton"));
    up.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e){
        spin.setValue(spin.getValue() + 1);
      }
    });
    down.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e){
        spin.setValue(spin.getValue() - 1);
      }
    });
    JPanel jp = new JPanel();
    jp.add(spin);
    jp.add(up);
    jp.add(down);
    jp.setBorder(new TitledBorder("Spinner"));
    add(jp);
    left.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e){
        stringSpin.setValue(
          stringSpin.getValue() + 1);
      }
    });
    right.addActionListener(new ActionListener(){
      public void actionPerformed(ActionEvent e){
        stringSpin.setValue(
          stringSpin.getValue() - 1);
      }
    });
    jp = new JPanel();
    jp.add(stringSpin);
    jp.add(left);
    jp.add(right);
    jp.setBorder(
      new TitledBorder("StringSpinner"));
    add(jp);
  }
  public static void main(String args[]) {
    Show.inFrame(new Buttons(), 300, 200);
  }
} ///:~