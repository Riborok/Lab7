Program Lab7;
{
 Sort the elements of the matrix columns in non-decreasing order, and the columns
 in ascending order by the products of the moduli of the odd column elements
}


{$APPTYPE CONSOLE}

uses
  System.SysUtils;

Const
  MaxI = 9;
  MaxJ = 7;
  // MaxI - the amount of lines in the matrix
  // MaxJ - the amount of columns in the matrix

Var
  Matrix, SortedMatrix : Array[1..MaxI, 1..MaxJ] of ShortInt;
  ProdColumns : array [1..2, 1..MaxJ] of LongWord;
  i, j, k, SortedPart : Byte;
  Temp: Integer;
  // Martix - initial matrix
  // SortedMatrix - sorted matrix
  // ProdColumns - an array that, in the first line, stores the products of
  // the moduli of the odd column elements. To the second column number corresponding to the product
  // i, j, l - cycle counter
  // SortedPart - sorted part in bubble sort
  // Temp - Temp

Begin

  Writeln('Initial matrix:');
  Writeln;

  // Fill the matrix with possible numbers and output it
  Randomize;
  for i := 1 to MaxI do
  begin
    for j := 1 to MaxJ do
    begin
      Matrix[i,j]:= Random(256) - 128;
      Write(Matrix[i,j]:5,' ');
    end;
    Writeln;
    Writeln;
  end;

  // Count the products of the moduli of the odd column elements
  for j := 1 to MaxJ do
  begin

    // Initializing variables
    ProdColumns[1,j]:= 1;
    ProdColumns[2,j]:= j;

    // Finding the product of odd elements
    i:= 1;
    while i <= MaxI do
    begin
      ProdColumns[1,j]:= ProdColumns[1,j] * Abs(Matrix[i,j]);
      Inc(i, 2);
    end;
    Write('The product of the ',j,' column = ',ProdColumns[1,j]);
    Writeln;
    Writeln;
  end;
  Writeln;

  // Sort ProdColumns in ascending order using bubble sort with fast border
  j:= 2;
  while j <= MaxJ do
  begin

    // Assume that the matrix is completely sorted
    SortedPart:= MaxJ;

    // Checking all neighbors to the border. If find inconsistencies, swap them
    for k:= MaxJ downto j do
      if ProdColumns[1,k] < ProdColumns[1,k-1] then
      begin

        // Swap the neighbors from the first line using the Temp
        Temp:= ProdColumns[1,k];
        ProdColumns[1,k]:= ProdColumns[1,k-1];
        ProdColumns[1,k-1]:= Temp;

        // Swap the neighbors from the second line using the Temp
        Temp:= ProdColumns[2,k];
        ProdColumns[2,k]:= ProdColumns[2,k-1];
        ProdColumns[2,k-1]:= Temp;

        // Ñhange the sorted part
        SortedPart:= k;
      end;

    // Modernize j given the sorted part
    j:= SortedPart + 1;
  end;

  // Form a sorted array, given the already sorted order of the columns
  for j := 1 to MaxJ do
      for i := 1 to MaxI do
        SortedMatrix[i,j]:= Matrix[i,ProdColumns[2,j]];

  // Sort SortedMatrix columns in non-decreasing order using insertion sort
  for j := 1 to MaxJ do
    for i:= 2 to MaxI do
    begin

      // Adding the current checked number to the Temp
      Temp:= SortedMatrix[i,j];

      // Initialize j for the cycle
      k:=i-1;

      // Change numbers until all elements are sorted up to the current number
      while (k >= 1) and (SortedMatrix[k,j] > Temp) do
      begin
        SortedMatrix[k+1,j]:=SortedMatrix[k,j];
        k:=k-1;
      end;

      // Assign the number reached in the cycle to the Temp
      SortedMatrix[k+1,j]:= Temp;
    end;

  Writeln;
  Writeln('Sorted matrix');
  Writeln;

  for i := 1 to MaxI do
  begin
    for j := 1 to MaxJ do
      Write(SortedMatrix[i,j]:5,' ');
    Writeln;
    Writeln;
  end;

  for j := 1 to MaxJ do
  begin
    Write('The product of the ',j,' column = ',ProdColumns[1,j]);
    Writeln;
    Writeln;
  end;

  Readln;
End.
