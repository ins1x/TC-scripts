mydate = Right("0" & Day(date), 2) & "-" & Right("0" & Month(date), 2) & "-" & Year(date)
WScript.CreateObject("WScript.Shell").SendKeys "{F7}" & mydate & "{Enter}" & "{Enter}"
