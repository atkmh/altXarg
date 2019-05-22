package test.java.com.matrixJava;

import main.java.com.matrixJava.Matrix;

public class TestMatrix {

	public static void main(String[] args) {
		System.out.println("Testing from within TestMatrix Class");

		int i=3,j=4;
		int testR=3, testC=4, A=22, B=33, C=12, D=13, E=17, F=11;
		
		Matrix testMatrix = new Matrix(i, j, A, B, C, D );
		Matrix secTestM = new Matrix (i,j,i*A,j*B,i*C,j*D);
	}

}
