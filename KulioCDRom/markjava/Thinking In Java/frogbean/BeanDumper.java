//: BeanDumper.java
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

// A method to introspect a Bean
import java.beans.*;
import java.lang.reflect.*;

public class BeanDumper {
  public static void dump(Class bean){
    BeanInfo bi = null;
    try {
      bi = Introspector.getBeanInfo(
        bean, java.lang.Object.class);
    } catch(IntrospectionException ex) {
      System.out.println("Couldn't introspect " +
        bean.getName());
      System.exit(1);
    }
    PropertyDescriptor[] properties = 
      bi.getPropertyDescriptors();
    for(int i = 0; i < properties.length; i++) {
      Class p = properties[i].getPropertyType();
      System.out.println(
        "Property type:\n  " + p.getName());
      System.out.println(
        "Property name:\n  " + 
        properties[i].getName());
      Method readMethod = 
        properties[i].getReadMethod();
      if(readMethod != null)
        System.out.println(
          "Read method:\n  " + 
          readMethod.toString());
      Method writeMethod = 
        properties[i].getWriteMethod();
      if(writeMethod != null)
        System.out.println(
          "Write method:\n  " +
          writeMethod.toString());
      System.out.println("====================");
    }
    System.out.println("Public methods:");
    MethodDescriptor[] methods =
      bi.getMethodDescriptors();
    for(int i = 0; i < methods.length; i++)
      System.out.println(
        methods[i].getMethod().toString());
    System.out.println("======================");
    System.out.println("Event support:");
    EventSetDescriptor[] events = 
      bi.getEventSetDescriptors();
    for(int i = 0; i < events.length; i++) {
      System.out.println("Listener type:\n  " +
        events[i].getListenerType().getName());
      Method[] lm = 
        events[i].getListenerMethods();
      for(int j = 0; j < lm.length; j++)
        System.out.println(
          "Listener method:\n  " +
          lm[j].getName());
      MethodDescriptor[] lmd = 
        events[i].getListenerMethodDescriptors();
      for(int j = 0; j < lmd.length; j++)
        System.out.println(
          "Method descriptor:\n  " +
          lmd[j].getMethod().toString());
      Method addListener = 
        events[i].getAddListenerMethod();
      System.out.println(
          "Add Listener Method:\n  " +
        addListener.toString());
      Method removeListener =
        events[i].getRemoveListenerMethod();
      System.out.println(
        "Remove Listener Method:\n  " +
        removeListener.toString());
      System.out.println("====================");
    }
  }
  // Dump the class of your choice:
  public static void main(String[] args) {
    if(args.length < 1) {
      System.err.println("usage: \n" +
        "BeanDumper fully.qualified.class");
      System.exit(0);
    }
    Class c = null;
    try {
      c = Class.forName(args[0]);
    } catch(ClassNotFoundException ex) {
      System.err.println(
        "Couldn't find " + args[0]);
      System.exit(0);
    }
    dump(c);
  }
} ///:~