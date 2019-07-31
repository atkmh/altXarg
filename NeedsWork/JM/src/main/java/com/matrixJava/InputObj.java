package main.java.com.matrixJava;

public class InputObj {
	
	private double[] mxValues;
	private int M;
	private int N;
	private String  itemName;
	private String opperationalMode;

	

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	
	public void setM(int M) {
		this.M = M;
	}

	public void setN(int N) {
		this.N = N;
	}
	
	public void setCell(int index, double val) {
		this.mxValues[index] = val;
	}
	
	public void setOppMode(String mode) {
		this.opperationalMode = mode;
	}
}
