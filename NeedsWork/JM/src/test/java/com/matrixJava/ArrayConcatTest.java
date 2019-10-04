package test.java.com.matrixJava;
import java.util.stream.Stream;
import java.util.Arrays;
import java.io.*;

  
class ArrayConcatTest { 
      
    public static <T> Object[] concatenate(T[] a, T[] b) 
    { 
        // Function to merge two arrays of  
        // same type 
        return Stream.concat(Arrays.stream(a), Arrays.stream(b)).toArray(); 
    } 
      
    public static void main (String[] args)  
    { 
        Integer[] a = new Integer[]{1,2,3}; 
        Integer[] b = new Integer[]{4,5,6}; 
      
        Object[] c = concatenate(a,b); 
          
  
    System.out.println("Merged object array : " + Arrays.toString(c)); 
    } 
} 