c  ***********************************************************************
c  *                                                                     *
c  *                            Function dcgelu                          *
c  *                                                                     *
c  ***********************************************************************
c  Double Precision/Complex Version 1.1
c  Written by Gordon A. Fenton, TUNS, 1991
c  Latest Update: Dec 5, 1996
c
c  PURPOSE  to compute the complex determinant of a complex square matrix
c           A through its LU decomposition employing naive Gaussian
c           Elimination. The LU decomposition is stored directly in A.
c
c  This function reduces a matrix A into its (Doolittle) LU decomposition
c  `in place',
c
c      [L][U] = [A]    ===>   [A] <== [L\U]
c
c  As a by-product of the decomposition, the determinant is returned in the
c  function name. If the matrix [A] is found to be algorithmically singular,
c  then the determinant is set to zero and the function exited.
c  The matrix [L] is assumed to be unit lower triangular (ie., having 1's
c  on the diagonal) -- thus only the subdiagonal terms of [L] are stored
c  in [A]. Arguments to the routine are as follows;
c
c     A    complex array of size at least n x n containing on input the complex
c          matrix coefficients. On ouput, A will contain the LU
c          decomposition of the row permuted version of A. (input/output)
c
c    ia    leading dimension of A exactly as specified in the calling routine.
c          (input)
c
c     n    integer giving the size of the matrix A. (input)
c
c  REVISION HISTORY:
c  1.1	replace `complex*16' declaration with `double complex' (Dec 5/96)
c-----------------------------------------------------------------------------
      double complex function dcgelu( A, ia, n )
      implicit real*8 (a-h,o-z)
      logical ldczer
      double complex A(ia,1), dcmplx
      data zero/0.0d0/, one/1.0d0/

c					forward reduce A
      dcgelu   = dcmplx( one, zero )
      do 20 k = 1, n - 1
c						update determinant
         dcgelu = dcgelu*A(k,k)
c						check for alg. singularity
         if( ldczer(A(k,k)) ) return
c						compute elements of L
         do 10 i = k+1, n
            A(i,k) = A(i,k)/A(k,k)
  10     continue
c						and eliminate (subtract rows)
         do 20 j = k+1, n
         do 20 i = k+1, n
            A(i,j) = A(i,j) - A(i,k)*A(k,j)
  20  continue
c					include last diagonal element
      dcgelu = dcgelu*A(n,n)

      return
      end
