package main.java.com.matrixJava;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class RowOperation {
	
	int resultantRow = 0;
	int sourceRow = 0;
	double scalertoApply = 0.00;
	String strAct = "";
	static Scanner in;
	
    RowOperation() {
        in = new Scanner(System.in);
     //   RowOperations myOperator = new RowOperations();
    	//Scanner in  = new Scanner(System.in);
//        myOperator.in = new Scanner(System.in);

    } // constructor end

    public void PrepRowAndScaler() {
        this.getResultantRow(); 
        this.getScalerToApply("Enter Scaler to multiply your row by :");
    }
    
    public void PrepRowScalerForAddToRow() {
        this.getResultantRow();  /************/
        this.getSourceRow();
        this.getScalerToApply("Enger Scaler multiply to source row then add to result :");
    }
    
    public void getResultantRow() {
    	System.out.println("Regarding Matrix "+MyApp.currentMx.getName() +" Counting from Zero");
    	System.out.println("Which row will we apply calculations to:");
    	resultantRow = in.nextInt();
    }
    
    public void getSourceRow() {
    	System.out.println("Counting from Zero");
    	System.out.println("Enter the row you will multiply and add to result row : ");
    	sourceRow = in.nextInt();
    }
    
   public void getScalerToApply(String explanation) {
	  String tempStr;
	  double numerator;
	  double denom;
	  System.out.println(explanation); 
	  tempStr = in.next();
	  if ((tempStr.contains("f")) || (tempStr.contains("f ")))
	  {   System.out.println("Enter fractional components");
	      System.out.print(":");
		  numerator =  Double.parseDouble(RowOperation.in.next());
		  System.out.print(":");
		  denom = Double.parseDouble(RowOperation.in.next());
		  scalertoApply = ( numerator / denom );
     }else 
	  scalertoApply =  Double.parseDouble(tempStr);
   }
   

    public Matrix RowOps(Matrix MX) {
    	
        Matrix newMx = new Matrix(MX.getRowDimension(), MX.getColumnDimension());
        newMx = MX.copy();
        double [][] C = newMx.getArray();
        for (int x=0; x < C[this.resultantRow].length; x++ ) 
        	C[this.resultantRow][x] = C[this.resultantRow][x] * scalertoApply;
        return newMx;	
    }
    
   public Matrix RsltRowMultbyScaler(Matrix MX) {
       Matrix newMx = new Matrix(MX.getRowDimension(), MX.getColumnDimension());
       newMx = MX.copy();
       double [][] C = newMx.getArray();
       for (int x=0; x < C[this.resultantRow].length; x++ ) 
       	C[this.resultantRow][x] = C[this.resultantRow][x] * scalertoApply;
       
       String thisRowOperation;
       thisRowOperation = "R"+resultantRow+"<-R"+resultantRow+"*"+scalertoApply ;
       newMx.setRowOperation(thisRowOperation);
       newMx.setModTimeStamp();
       return newMx;	
   }

    
   public Matrix RsltRowAddedToSrcRowMultbyScaler(Matrix MX) {
       Matrix newMx = new Matrix(MX.getRowDimension(), MX.getColumnDimension());
       newMx = MX.copy();
       double [][] C = newMx.getArray();
       double tempRowCpy[] = new double[ C[sourceRow].length ];
       
       // get a copy of the source row and multiply by the scaler
       for (int x=0; x < C[sourceRow].length; x++ ) 
    	   tempRowCpy[x] = ( C[sourceRow][x] )*scalertoApply;

      // Add the scaler modified source row to the resultant row 
       for (int x=0 ; x < tempRowCpy.length ; x++ )
           C[resultantRow][x] = C[resultantRow][x] + tempRowCpy[x];
      
       String thisRowOpp;
       thisRowOpp = "R"+resultantRow+"<-R"+resultantRow+"+R"+sourceRow+"*"+scalertoApply;
       
       newMx.setRowOperation(thisRowOpp);
       newMx.setModTimeStamp();
	   return newMx ;
	   }





    
}
