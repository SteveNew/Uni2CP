program UNI2CP;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes;

var
  Enc : TEncoding;
  str : TStringList;

begin
  if ParamCount<3 then
  begin
    Writeln('UNI2CP convert unicode text files, into text files using given ANSI/OEM codepage.');
    Writeln('Usage: UNI2CP <inputfile> <OEM/ASNI_Codepage> <outputfile>');
    Writeln('Example: UNI2CP unicode_file.txt 1253 greek_oem.txt');
  end
  else
  begin
    try
      if FileExists(ParamStr(1)) then
      begin
        str := TStringList.Create;
        str.LoadFromFile(ParamStr(1), TEncoding.Unicode);
        Enc := TEncoding.GetEncoding(StrToInt(ParamStr(2)));
        try
          str.SaveToFile(ParamStr(3), Enc);
        finally
          Enc.Free;
          str.Free;
        end;
      end
      else
        Writeln('ERROR: Can''t find inputfile.');
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
end.
