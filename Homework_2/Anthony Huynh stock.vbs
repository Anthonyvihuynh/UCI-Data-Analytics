'Please run this
Sub loops()
Dim ws As Worksheet

'runs sub volume for each worksheet
For Each ws In ActiveWorkbook.Worksheets
    ws.Activate
    Call volume(ws)
    Next

MsgBox ("Completed!")

End Sub

Sub volume(ws As Worksheet)

Dim ticker() As String 'ticker array
Dim tickcount() As Long 'Amount of each ticker
Dim tickname As String 'Holds ticker abbreviation
Dim count As Integer 'Counts amount of different tickers
Dim lastrow As Long 'total number of rows
Dim volrange As Long 'tracks used rows
Dim OP As Double 'tracks open value
Dim CL As Double 'tracks close value
Dim Sheetcount As Integer 'counts number of worksheets

With ws

'create headers
Cells(1, 9) = "Ticker"
Cells(1, 10) = "Yearly Change"
Cells(1, 11) = "Percent Change"
Cells(1, 12) = "Total Stock Volume"
Cells(1, 16) = "Ticker"
Cells(1, 17) = "Value"
Cells(2, 15) = "Greatest % Increase"
Cells(3, 15) = "Greatest % Decrease"
Cells(4, 15) = "Greatest Total Volume"

'Find total number rows
lastrow = Cells(Rows.count, 1).End(xlUp).Row

'Find number of tickers
count = 0
For i = 2 To lastrow
    If Cells(i, 1) <> Cells(i + 1, 1) Then 'if ticker name doesn't equal next ticker name, add 1 to counter
        count = count + 1
        Else: End If
    Next i

'Sets number of array
ReDim ticker(0 To count) 'from zero to number of unique tickers
ReDim tickcount(0 To count)

x = 0 'Beginning number of array

'Assign each array a different ticker abbreviation
'Grabs range of each ticker
ticker(0) = Cells(2, 1)
For n = 2 To lastrow
    If ticker(x) = Cells(n, 1) Then 'if ticker name equals target cell, add 1 to that ticker's count
        tickcount(x) = tickcount(x) + 1 'counter per index
        Else: ticker(x + 1) = Cells(n, 1) 'if doesn't equal, move to the next ticker
        x = x + 1
        End If
Next n

'Paste tickers and volume counts
'Need more elegant solution
volrange = 2 'variable to pull already used rows, starts at 2 due to headers
For x = 0 To count
    Cells(x + 2, 9) = ticker(x)
    OP = Cells(volrange, 3).Value 'Opening value
    If volrange = 2 Then volrange = 1 'needs to reset to 1 or else doesn't work lol
    CL = Cells(volrange + tickcount(x), 6).Value 'closing value
    Cells(x + 2, 12) = Application.Sum(Range(Cells(volrange, 7), Cells(volrange + tickcount(x), 7))) 'sum of volume for a ticker
    Cells(x + 2, 10) = CL - OP 'Yearly change
    If OP = 0 Then 'no dividing by zero!
    Cells(x + 2, 11) = 0
        Else: Cells(x + 2, 11) = CL / OP - 1 'Percentage change
        End If
    volrange = volrange + tickcount(x) + 1 'sets volrange to equal amount of new rows used
Next x

'misc troubleshooting code
'Cells(volrange + tickcount(x), 1).Select
'Cells(volrange, 1).Select

'conditional format
    Columns("J:J").Select
    Selection.FormatConditions.Add Type:=xlCellValue, Operator:=xlGreater, _
        Formula1:="=0"
    Selection.FormatConditions(Selection.FormatConditions.count).SetFirstPriority
    With Selection.FormatConditions(1).Font
        .Color = -16752384
        .TintAndShade = 0
    End With
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .Color = 13561798
        .TintAndShade = 0
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlCellValue, Operator:=xlLess, _
        Formula1:="=0"
    Selection.FormatConditions(Selection.FormatConditions.count).SetFirstPriority
    With Selection.FormatConditions(1).Font
        .Color = -16383844
        .TintAndShade = 0
    End With
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .Color = 13551615
        .TintAndShade = 0
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Range("J1").Select
    Selection.FormatConditions.Delete

'number formatting
    Columns("K:K").Select
    Selection.Style = "Percent"
    Selection.NumberFormat = "0.00%"
    Columns("J:J").Select
    Selection.NumberFormat = "0.000000000"

'Find "Greatest"s
Cells(2, 17).Select
    Selection = WorksheetFunction.Max(Range("K:K"))
    Selection.Style = "Percent"
    Selection.NumberFormat = "0.00%"
Cells(3, 17).Select
    Selection = WorksheetFunction.Min(Range("K:K"))
    Selection.Style = "Percent"
    Selection.NumberFormat = "0.00%"
Cells(4, 17) = WorksheetFunction.Max(Range("L:L"))
Columns("A:Q").AutoFit

'Match Tickers
Cells(2, 16).Formula = "=index(I2:I" & count + 2 & ",Match(Q2,K2:K" & count + 2 & ",0))"
Cells(3, 16).Formula = "=index(I2:I" & count + 2 & ",Match(Q3,K2:K" & count + 2 & ",0))"
Cells(4, 16).Formula = "=index(I2:I" & count + 2 & ",Match(Q4,L2:L" & count + 2 & ",0))"

Cells(1, 1).Select

'next worksheet
End With

End Sub
