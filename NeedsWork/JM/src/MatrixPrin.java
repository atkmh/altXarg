// package main.java.com.matrixJava;

/* *****************************************************************************
 *  Compilation:  javac Matrix.java
 *  Execution:    java Matrix
 *
 *  A bare-bones immutable data type for M-by-N matrices.
 *
 ******************************************************************************/

/* *********************************
 *	Need to do....
 *	Finish blocking out Constructors, Public methods, etc
 * 	Write up what we can expect to need for in the way of "R4 + (-3)R1 -> R4"   
 *	or would this be better explained R4 = R4 + (-3)R1    or even R4 = R4 - 3R1 
 */



final public class MatrixPrin { // Mark:  Called MatrixPrin for Princeton where I found this EXAMPLE`
    private final int M;             // number of rows
    private final int N;             // number of columns
    private final double[][] data;   // M-by-N array
    private String m_VarName;

    // create M-by-N matrix of 0's  //		Mark: I think this is an inherent Java thing 
    public MatrixPrin(int M, int N) {//		on initialization all are set to Zeros(0)
        this.M = M;
        this.N = N;
        data = new double[M][N];
    }

    // create matrix based on 2d array
    public MatrixPrin(double[][] data) {
        M = data.length;
        N = data[0].length;
        this.data = new double[M][N];
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                    this.data[i][j] = data[i][j];
    }

    // copy constructor
    private MatrixPrin(MatrixPrin A) { this(A.data); }

    // create and return a random M-by-N matrix with values between 0 and 1
    public static MatrixPrin random(int M, int N) {
    	MatrixPrin A = new MatrixPrin(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                A.data[i][j] = Math.random();
        return A;
    }

    // create and return the N-by-N identity matrix
    public static MatrixPrin identity(int N) {
    	MatrixPrin I = new MatrixPrin(N, N);
        for (int i = 0; i < N; i++)
            I.data[i][i] = 1;
        return I;
    }

    // swap rows i and j
    private void swap(int i, int j) {
        double[] temp = data[i];
        data[i] = data[j];
        data[j] = temp;
    }

    // create and return the transpose of the invoking matrix
    public MatrixPrin transpose() {
        MatrixPrin A = new MatrixPrin(N, M);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                A.data[j][i] = this.data[i][j];
        return A;
    }

    // return C = A + B
    public MatrixPrin plus(MatrixPrin B) {
        MatrixPrin A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        MatrixPrin C = new MatrixPrin(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                C.data[i][j] = A.data[i][j] + B.data[i][j];
        return C;
    }


    // return C = A - B
    public MatrixPrin minus(MatrixPrin B) {
        MatrixPrin A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        MatrixPrin C = new MatrixPrin(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                C.data[i][j] = A.data[i][j] - B.data[i][j];
        return C;
    }

    // does A = B exactly?
    public boolean eq(MatrixPrin B) {
        MatrixPrin A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                if (A.data[i][j] != B.data[i][j]) return false;
        return true;
    }

    // return C = A * B
    public MatrixPrin times(MatrixPrin B) {
        MatrixPrin A = this;
        if (A.N != B.M) throw new RuntimeException("Illegal matrix dimensions.");
        MatrixPrin C = new MatrixPrin(A.M, B.N);
        for (int i = 0; i < C.M; i++)
            for (int j = 0; j < C.N; j++)
                for (int k = 0; k < A.N; k++)
                    C.data[i][j] += (A.data[i][k] * B.data[k][j]);
        return C;
    }


    // return x = A^-1 b, assuming A is square and has full rank
    public MatrixPrin solve(MatrixPrin rhs) {
        if (M != N || rhs.M != N || rhs.N != 1)
            throw new RuntimeException("Illegal matrix dimensions.");

        // create copies of the data
        MatrixPrin A = new MatrixPrin(this);
        MatrixPrin b = new MatrixPrin(rhs);

        // Gaussian elimination with partial pivoting
        for (int i = 0; i < N; i++) {

            // find pivot row and swap
            int max = i;
            for (int j = i + 1; j < N; j++)
                if (Math.abs(A.data[j][i]) > Math.abs(A.data[max][i]))
                    max = j;
            A.swap(i, max);
            b.swap(i, max);

            // singular
            if (A.data[i][i] == 0.0) throw new RuntimeException("Matrix is singular.");

            // pivot within b
            for (int j = i + 1; j < N; j++)
                b.data[j][0] -= b.data[i][0] * A.data[j][i] / A.data[i][i];

            // pivot within A
            for (int j = i + 1; j < N; j++) {
                double m = A.data[j][i] / A.data[i][i];
                for (int k = i+1; k < N; k++) {
                    A.data[j][k] -= A.data[i][k] * m;
                }
                A.data[j][i] = 0.0;
            }
        }

        // back substitution
        MatrixPrin x = new MatrixPrin(N, 1);
        for (int j = N - 1; j >= 0; j--) {
            double t = 0.0;
            for (int k = j + 1; k < N; k++)
                t += A.data[j][k] * x.data[k][0];
            x.data[j][0] = (b.data[j][0] - t) / A.data[j][j];
        }
        return x;
   
    }

    // print matrix to standard output
    public void show() {
    	System.out.println("Matrix: " +this.m_VarName);
        for (int i = 0; i < M; i++) {
            for (int j = 0; j < N; j++) {
//                System.out.println("%9.4f ", data[i][j]);
//                System.out.println( data[i][j]);
                System.out.printf("%.3f  ", data[i][j] );
            } System.out.println();
        }
    }



    // test client
    public static void main(String[] args) {
        double[][] d = { { 11, 2, 3 }, { 4, 15, 6 }, { 9, 1, 23} };
        MatrixPrin D = new MatrixPrin(d);
        D.m_VarName = "D";
        D.show();        
        System.out.println();

		
		  MatrixPrin A = MatrixPrin.random(5, 5); 
		  A.m_VarName = "A_random";
		  A.show(); 
		  System.out.println();
		 
		 System.out.println("Swap:  A.swap(1, 2) Zero based ");
		 A.swap(1, 2); A.show(); System.out.println();
		
		 
		 System.out.println("B is A.transpose");
		 MatrixPrin B = A.transpose();
		 B.m_VarName = "B";
		 B.show(); System.out.println();
		 
		 MatrixPrin C = MatrixPrin.identity(5); 
		 C.m_VarName = "C_identity";
		 C.show(); System.out.println();
		  
		 A.plus(B).show(); System.out.println();
		  
		 /* B.times(A).show(); System.out.println();
		 * 
		 * // shouldn't be equal since AB != BA in general
		 * System.out.println(A.times(B).eq(B.times(A))); System.out.println();
		 * 
		 * MatrixPrin b = MatrixPrin.random(5, 1); b.show(); System.out.println();
		 * 
		 * MatrixPrin x = A.solve(b); x.show(); System.out.println();
		 * 
		 * A.times(x).show();
		 */
        
    }
}
